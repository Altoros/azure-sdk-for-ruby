module Azure::Core
  module XmlConverter

    included do |base|
      base.requires Azure::Core::XmlConverter
      base.extend ClassMethods      
    end

    def to_xml
      self.attributes.to_hash
    end

    
    module ClassMethods
      def from_xml(xml)

      end
    end

  end
end


