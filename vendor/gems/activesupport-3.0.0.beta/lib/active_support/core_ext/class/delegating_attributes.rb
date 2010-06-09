require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/array/extract_options'
require 'active_support/core_ext/object/metaclass'

class Class
  def superclass_delegating_accessor(name, options = {})
    # Create private _name and _name= methods that can still be used if the public
    # methods are overridden. This allows
    _superclass_delegating_accessor("_#{name}")

    # Generate the public methods name, name=, and name?
    # These methods dispatch to the private _name, and _name= methods, making them
    # overridable
    metaclass.send(:define_method, name) { send("_#{name}") }
    metaclass.send(:define_method, "#{name}?") { !!send("_#{name}") }
    metaclass.send(:define_method, "#{name}=") { |value| send("_#{name}=", value) }

    # If an instance_reader is needed, generate methods for name and name= on the
    # class itself, so instances will be able to see them
    define_method(name) { send("_#{name}") } if options[:instance_reader] != false
    define_method("#{name}?") { !!send("#{name}") } if options[:instance_reader] != false
  end

private

  # Take the object being set and store it in a method. This gives us automatic
  # inheritance behavior, without having to store the object in an instance
  # variable and look up the superclass chain manually.
  def _stash_object_in_method(object, method, instance_reader = true)
    metaclass.send(:define_method, method) { object }
    define_method(method) { object } if instance_reader
  end

  def _superclass_delegating_accessor(name, options = {})
    metaclass.send(:define_method, "#{name}=") do |value|
      _stash_object_in_method(value, name, options[:instance_reader] != false)
    end
    self.send("#{name}=", nil)
  end

end
