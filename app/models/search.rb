class Search < BaseWithoutTable
  #
  # (c) Mark Ronai
  #
  # This model is subclass of ActiveRecord::Base without coressponding table (BaseWithoutTable) to have access to scoped() ClassMethod
    
  attr_accessor :options, :klass, :named_scopes
  
  # creates a new search class instance to access search results 
  # example:
  #
  #   @search = Search.new(:product, :name => :like, :item_code => :equal, :named_scopes => [:has_multi_products] )
  #
  # The first attribute is the class name of the model you want to perform the search on. Options is a hash, which accepts model attributes as keys, and :equal, :not_equal, :like, :greater, :less or :is values that represent standard sql queries.
  # You can pass custom conditions in a string associated to a search parameter: :q => "email LIKE ? OR comment LIKE ?" #=> will generate: scope = scope.conditions ["email LIKE ? OR comment LIKE ?", send(:q),send(:q)] unless send(:q).blank?
  #  
  # To join a table, pass it in a :joins key (you can pass a named association symbol, an array of named association symbols, or a custom join string:) 
  #   :joins => :orders
  #   :joins => [:payment, :orders]
  #   :joins => "JOIN (SELECT id, item_code, MAX(default_config) AS default_config  FROM products GROUP BY item_code ) AS pm ON products.item_code = pm.item_code AND products.default_config = pm.default_config"
  #   
  # example: @search = Search.new(:order, :joins => :payment,  :q => "orders.order_number LIKE ? OR payments.#{gw_field} LIKE ? OR orders.shipping_company LIKE ? OR payments.purchase_order LIKE ?" )
  #
  # creates the following search method:
  #
  # def search(attribs = {})
  #   attribs.stringify_keys.each { |key,value| send("#{key}=", value) }
  #   scope = Order.scoped({:joins => :payment})
  #   scope = scope.scoped(:conditions => ["orders.order_number LIKE ? OR payments.vpstx_id LIKE ? OR orders.shipping_company LIKE ? OR payments.purchase_order LIKE ?", send(:q),send(:q),send(:q),send(:q)]) unless send(:q).blank?
  #   @named_scopes.each {|nc| scope = scope.send(nc) }
  #   scope
  # end
  #
  # you can set the values of the search attributes by setting the attributes previously specified (when the new Search object was initialized)
  #  
  #   @search.name = "Overview"  # => sets the value of :name attribute, but doesn't perform the search yet 
  #
  # or by passing a hash argument to the search method, (which btw executes the search):
  # 
  #   @search.search(:name => "Overview", :description => "idea") #=> will result this db query: SELECT * FROM products WHERE name = "Overview" AND description LIKE %idea&
  #
  # to chain additional pre-defined  named scopes, just pass an array in the :named_scopes hash key (good to build dynamic searches):
  #
  #   named_scopes = []                                    
  #   named_scopes << :availabe if params[:available]
  #   named_scopes << :blue_shirts if params[:blue_shirts]
  #
  #   @search.search(:name => "Overview", :description => "idea", :named_scopes => named_scopes) 

 
  def initialize(klass, options = {}, &block)
    super(nil)
    @klass = klass.to_s.camelize.constantize
    @joins = options.delete(:joins)
    @named_scopes = options.delete(:named_scopes)
    @options = options.stringify_keys
    @named_scopes ||= []
    build_search_method
  end
  
  # returns dynamically created attribute names and their values in a hash
  def dynamic_attributes
    da = {}
    @options.each_key { |key| da[key] = send(key) }
    da
  end
  
  # resets values of dynamic_attributes to nil
  def reset
    @options.each_key { |key| send("#{key}=", nil) }
    dynamic_attributes
  end

private
  
  def build_search_method
    new_method = []
    new_method << %Q(attribs.stringify_keys.each { |key,value| send("\#{key}=", value) })
    case @joins
    when Symbol
      new_method << %Q(scope = #{@klass}.scoped({:joins => :#{@joins}}))
    when Array
      new_method << %Q(scope = #{@klass}.scoped({:joins => [:#{@joins.join(',:')}]})) 
    when String
      new_method << %Q(scope = #{@klass}.scoped({:joins => "#{@joins}"}))
    else
      new_method << "scope = #{@klass}.scoped({})"
    end
    @options.each do |attrib, condition|
      next if attrib == "named_scopes"
      class_eval "attr_accessor :#{attrib}"
      scope = case 
      when condition == :like
        new_method << %Q(scope = scope.conditions "#{@klass.table_name}.#{attrib} LIKE ?", "%\#{send(:#{attrib})}%" unless send(:#{attrib}).blank?)
      when condition == :equal
        new_method << %Q(scope = scope.conditions "#{@klass.table_name}.#{attrib} = ?", send(:#{attrib}) unless send(:#{attrib}).blank?)
      when condition == :not_equal
        new_method << %Q(scope = scope.conditions "#{@klass.table_name}.#{attrib} != ?", send(:#{attrib}) unless send(:#{attrib}).blank?)
      when condition == :in
        new_method << %Q(scope = scope.conditions "#{@klass.table_name}.#{attrib} IN (?)", send(:#{attrib}) unless send(:#{attrib}).blank?)
      when condition == :greater
        new_method << %Q(scope = scope.conditions "#{@klass.table_name}.#{attrib} > ?", send(:#{attrib}) unless send(:#{attrib}).blank?)
      when condition == :less
        new_method << %Q(scope = scope.conditions "#{@klass.table_name}.#{attrib} < ?", send(:#{attrib}) unless send(:#{attrib}).blank?)
      when condition == :is
        new_method << %Q(scope = scope.conditions "#{@klass.table_name}.#{attrib} IS ?", send(:#{attrib}) unless send(:#{attrib}).blank?)
      when condition == :is_null
        new_method << %Q(scope = scope.conditions "#{@klass.table_name}.#{attrib} IS NULL")
      when condition.class == String
        new_method << %Q(scope = scope.scoped(:conditions => ["#{condition}", #{Array.new(condition.scan("?").length) { |i| "send(:#{attrib})" }.join(",")}]) unless send(:#{attrib}).blank?)
      end
    end
    new_method << %Q(@named_scopes.each {|nc| scope = scope.send(nc) })
    class_eval %Q(def search(attribs = {})\n  #{new_method.join("\n  ")}\n  scope\nend)
  end

end
