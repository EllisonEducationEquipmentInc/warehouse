module Rails
  class Application
    module Finisher
      include Initializable

      initializer :ensure_load_once_paths_as_subset do
        extra = ActiveSupport::Dependencies.load_once_paths -
                ActiveSupport::Dependencies.load_paths

        unless extra.empty?
          abort <<-end_error
            load_once_paths must be a subset of the load_paths.
            Extra items in load_once_paths: #{extra * ','}
          end_error
        end
      end

      initializer :add_to_prepare_blocks do
        config.to_prepare_blocks.each do |block|
          ActionDispatch::Callbacks.to_prepare(&block)
        end
      end

      initializer :add_builtin_route do |app|
        if Rails.env.development?
          app.routes_reloader.paths << File.join(RAILTIES_PATH, 'builtin', 'routes.rb')
        end
      end

      initializer :build_middleware_stack do
        app
      end

      # Fires the user-supplied after_initialize block (config.after_initialize)
      initializer :after_initialize do
        config.after_initialize_blocks.each do |block|
          block.call(self)
        end
      end

      # Disable dependency loading during request cycle
      initializer :disable_dependency_loading do
        if config.cache_classes && !config.dependency_loading
          ActiveSupport::Dependencies.unhook!
        end
      end
    end
  end
end