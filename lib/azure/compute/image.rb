#-------------------------------------------------------------------------
# Copyright 2013 Microsoft Open Technologies, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#--------------------------------------------------------------------------


module Azure::Conmpute

  class Image < Resource
    

    required_attribute :os, 
    required_attribute :name, 
    required_attribute :category, 
    required_attribute :location, 


    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.OSImage('xmlns'=>'http://schemas.microsoft.com/windowsazure') do
          xml.Label Base64.encode64(self.label).strip
          xml.Name self.name
          xml.Category self.category
          xml.Location self.location
          xml.OS self.os
        end
      end
      builder.doc.to_xml
    end

    def self.from_xml(xml)
      os_images = Array.new
      images = imageXML.css('Images OSImage')
      images.map do |image_node|
        os       = xml_content(image_node, 'OS')
        name     = xml_content(image_node, 'Name')
        category = xml_content(image_node, 'Category')
        location = xml_content(image_node, 'Location')
        Image.new(os: os, name: name, category: category, location: location)
      end
    end
    
    def required_attributes
      [:os, :name, :category, :locations]
    end
  end
end
