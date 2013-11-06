module Azure::Core
  module Validation

    def valid?
      errors.empty?
    end

    def errors
      @errors ||= []
    end


    def run_validators
      required_attributes
    end

    def required_attributes
      self.class.required_attributes_for()
    end

    module ClassMethods

      def validate(message, &block)
        custom_validators << block
      end

    end



  end
end