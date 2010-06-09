require 'active_support/core_ext/hash/diff'

module ActionDispatch
  module Assertions
    # Suite of assertions to test routes generated by Rails and the handling of requests made to them.
    module RoutingAssertions
      # Asserts that the routing of the given +path+ was handled correctly and that the parsed options (given in the +expected_options+ hash)
      # match +path+.  Basically, it asserts that Rails recognizes the route given by +expected_options+.
      #
      # Pass a hash in the second argument (+path+) to specify the request method.  This is useful for routes
      # requiring a specific HTTP method.  The hash should contain a :path with the incoming request path
      # and a :method containing the required HTTP verb.
      #
      #   # assert that POSTing to /items will call the create action on ItemsController
      #   assert_recognizes({:controller => 'items', :action => 'create'}, {:path => 'items', :method => :post})
      #
      # You can also pass in +extras+ with a hash containing URL parameters that would normally be in the query string.  This can be used
      # to assert that values in the query string string will end up in the params hash correctly.  To test query strings you must use the
      # extras argument, appending the query string on the path directly will not work.  For example:
      #
      #   # assert that a path of '/items/list/1?view=print' returns the correct options
      #   assert_recognizes({:controller => 'items', :action => 'list', :id => '1', :view => 'print'}, 'items/list/1', { :view => "print" })
      #
      # The +message+ parameter allows you to pass in an error message that is displayed upon failure.
      #
      # ==== Examples
      #   # Check the default route (i.e., the index action)
      #   assert_recognizes({:controller => 'items', :action => 'index'}, 'items')
      #
      #   # Test a specific action
      #   assert_recognizes({:controller => 'items', :action => 'list'}, 'items/list')
      #
      #   # Test an action with a parameter
      #   assert_recognizes({:controller => 'items', :action => 'destroy', :id => '1'}, 'items/destroy/1')
      #
      #   # Test a custom route
      #   assert_recognizes({:controller => 'items', :action => 'show', :id => '1'}, 'view/item1')
      #
      #   # Check a Simply RESTful generated route
      #   assert_recognizes list_items_url, 'items/list'
      def assert_recognizes(expected_options, path, extras={}, message=nil)
        if path.is_a? Hash
          request_method = path[:method]
          path           = path[:path]
        else
          request_method = nil
        end

        request = recognized_request_for(path, request_method)

        expected_options = expected_options.clone
        extras.each_key { |key| expected_options.delete key } unless extras.nil?

        expected_options.stringify_keys!
        routing_diff = expected_options.diff(request.path_parameters)
        msg = build_message(message, "The recognized options <?> did not match <?>, difference: <?>",
            request.path_parameters, expected_options, expected_options.diff(request.path_parameters))
        assert_block(msg) { request.path_parameters == expected_options }
      end

      # Asserts that the provided options can be used to generate the provided path.  This is the inverse of +assert_recognizes+.
      # The +extras+ parameter is used to tell the request the names and values of additional request parameters that would be in
      # a query string. The +message+ parameter allows you to specify a custom error message for assertion failures.
      #
      # The +defaults+ parameter is unused.
      #
      # ==== Examples
      #   # Asserts that the default action is generated for a route with no action
      #   assert_generates "/items", :controller => "items", :action => "index"
      #
      #   # Tests that the list action is properly routed
      #   assert_generates "/items/list", :controller => "items", :action => "list"
      #
      #   # Tests the generation of a route with a parameter
      #   assert_generates "/items/list/1", { :controller => "items", :action => "list", :id => "1" }
      #
      #   # Asserts that the generated route gives us our custom route
      #   assert_generates "changesets/12", { :controller => 'scm', :action => 'show_diff', :revision => "12" }
      def assert_generates(expected_path, options, defaults={}, extras = {}, message=nil)
        expected_path = "/#{expected_path}" unless expected_path[0] == ?/
        # Load routes.rb if it hasn't been loaded.

        generated_path, extra_keys = ActionController::Routing::Routes.generate_extras(options, defaults)
        found_extras = options.reject {|k, v| ! extra_keys.include? k}

        msg = build_message(message, "found extras <?>, not <?>", found_extras, extras)
        assert_block(msg) { found_extras == extras }

        msg = build_message(message, "The generated path <?> did not match <?>", generated_path,
            expected_path)
        assert_block(msg) { expected_path == generated_path }
      end

      # Asserts that path and options match both ways; in other words, it verifies that <tt>path</tt> generates
      # <tt>options</tt> and then that <tt>options</tt> generates <tt>path</tt>.  This essentially combines +assert_recognizes+
      # and +assert_generates+ into one step.
      #
      # The +extras+ hash allows you to specify options that would normally be provided as a query string to the action.  The
      # +message+ parameter allows you to specify a custom error message to display upon failure.
      #
      # ==== Examples
      #  # Assert a basic route: a controller with the default action (index)
      #  assert_routing '/home', :controller => 'home', :action => 'index'
      #
      #  # Test a route generated with a specific controller, action, and parameter (id)
      #  assert_routing '/entries/show/23', :controller => 'entries', :action => 'show', :id => 23
      #
      #  # Assert a basic route (controller + default action), with an error message if it fails
      #  assert_routing '/store', { :controller => 'store', :action => 'index' }, {}, {}, 'Route for store index not generated properly'
      #
      #  # Tests a route, providing a defaults hash
      #  assert_routing 'controller/action/9', {:id => "9", :item => "square"}, {:controller => "controller", :action => "action"}, {}, {:item => "square"}
      #
      #  # Tests a route with a HTTP method
      #  assert_routing({ :method => 'put', :path => '/product/321' }, { :controller => "product", :action => "update", :id => "321" })
      def assert_routing(path, options, defaults={}, extras={}, message=nil)
        assert_recognizes(options, path, extras, message)

        controller, default_controller = options[:controller], defaults[:controller]
        if controller && controller.include?(?/) && default_controller && default_controller.include?(?/)
          options[:controller] = "/#{controller}"
        end

        assert_generates(path.is_a?(Hash) ? path[:path] : path, options, defaults, extras, message)
      end

      # A helper to make it easier to test different route configurations.
      # This method temporarily replaces ActionController::Routing::Routes
      # with a new RouteSet instance.
      #
      # The new instance is yielded to the passed block. Typically the block
      # will create some routes using <tt>map.draw { map.connect ... }</tt>:
      #
      #   with_routing do |set|
      #     set.draw do |map|
      #       map.connect ':controller/:action/:id'
      #         assert_equal(
      #           ['/content/10/show', {}],
      #           map.generate(:controller => 'content', :id => 10, :action => 'show')
      #       end
      #     end
      #   end
      #
      def with_routing
        real_routes = ActionController::Routing::Routes
        ActionController::Routing.module_eval { remove_const :Routes }

        temporary_routes = ActionController::Routing::RouteSet.new
        ActionController::Routing.module_eval { const_set :Routes, temporary_routes }

        yield temporary_routes
      ensure
        if ActionController::Routing.const_defined? :Routes
          ActionController::Routing.module_eval { remove_const :Routes }
        end
        ActionController::Routing.const_set(:Routes, real_routes) if real_routes
      end

      def method_missing(selector, *args, &block)
        if @controller && ActionController::Routing::Routes.named_routes.helpers.include?(selector)
          @controller.send(selector, *args, &block)
        else
          super
        end
      end

      private
        # Recognizes the route for a given path.
        def recognized_request_for(path, request_method = nil)
          path = "/#{path}" unless path.first == '/'

          # Assume given controller
          request = ActionController::TestRequest.new
          request.env["REQUEST_METHOD"] = request_method.to_s.upcase if request_method
          request.path = path

          params = ActionController::Routing::Routes.recognize_path(path, { :method => request.method })
          request.path_parameters = params.with_indifferent_access

          request
        end
    end
  end
end
