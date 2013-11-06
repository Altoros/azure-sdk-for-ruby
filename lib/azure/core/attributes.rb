module Azure::Core

  class Attribute
    attr_accessor :options

    def initialize(options)
      self.options = options
    end

    def required?
      @required = self.options[:required] || !options[:optional]
    end

  end

  module Attributes
    include Azure::Core::Concern

    def attributes
      @attributes
    end


    module ClassMethods

      def attribute_names
        @attribute_names ||= []
      end


      # options 
      #    type:     :string | :integer | :boolean | :mapping
      #    class:    class mapping ???
      #    required: false | true 
      #    xml_name: 

      def attribute(name, options = {}, &block)
        attr_accessor name
        attribute_names[name.to_sym] = name.to_sym
      end



    end
  end
end



# required_attributes
# attributes 

