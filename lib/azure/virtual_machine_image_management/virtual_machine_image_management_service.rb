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
require "azure/virtual_machine_image_management/serialization"
require "azure/virtual_machine/image"

module Azure
  module VirtualMachineImageManagement
    class VirtualMachineImageManagementService < BaseManagementService

      def initialize
        super()
      end

      # Public: Gets a list of virtual machine images from the server
      #
      # Returns an array of Azure::VirtualMachineImageManagementService objects
      def list_virtual_machine_images
        request_path = "/services/images"
        request = ManagementHttpRequest.new(:get, request_path, nil)
        response = request.call
        Serialization.virtual_machine_images_from_xml(response)
      end

      # Public: Creates an image based on the supplied configuration.
      #
      # ==== Attributes
      #
      # * +paramSpecifies the language of the image.s+     - Hash.  List of required parameters.
      # * +options+    - Hash.  Optional parameters.
      #
      #  ==== Params
      #
      # Accepted key/value pairs are:
      # * +:label+        - String.  Specifies the friendly name of the image.
      # * +:media_link+   - String.  Specifies the location of the blob in Windows Azure storage.
      # * +:name+         - String.  Specifies a name that is used to identify the image when creating virtual machines.
      # * +:os_type+      - String.  The operating system type of the OS image. Possible values are: Linux, Windows.
      #
      #  ==== Options
      #
      # Accepted key/value pairs are:
      # * +:eula+                  - String.  Specifies the End User License Agreement associated with the image. 
      # * +:description+           - String.  Specifies the description of the OS image.
      # * +:image_family+          - String.  Specifies a value that can be used to group OS images.
      # * +:published_date+        - String.  Specifies the date when the OS image was added to the image repository.
      # * +:is_premium+            - Boolean. Indicates if the image contains software or associated services that 
      #                                       will incur charges above the core price for the virtual machine.
      # * +:show_in_gui+           - Boolean. Specifies whether the image should appear in the image gallery.
      # * +:privacy_uri+           - String.  Specifies the SSH port number.
      # * +:icon_uri+              - String.  Specifies the size of the virtual machine instance.  
      # * +:recommended_vm_size+   - Integer. Specifies the size to use for the virtual machine that is created from the OS image.   
      # * +:small_icon_uri+        - String.  Specifies the URI to the small icon.
      # * +:language+              - String.  Specifies the language of the image.
      #
      # Returns Azure::VirtualMachineManagement::VirtualMachine objects of newly created instance.      
      # 
      # See http://msdn.microsoft.com/en-us/library/windowsazure/jj157192.aspx for details
      def create_virtual_machine_image(options)
        Loggerx.info "Creating Image \"#{name}\". "
        image = Image.new(options)
        image.validate!
        path = "/services/images"
        body = image.to_xml
        request = ManagementHttpRequest.new(:post, path, body)
        request.call
      end

    end

    class VirtualMachineDiskManagementService < BaseManagementService

      def initialize
        super()
      end

      # Public: Gets a list of Disks from the server.
      #
      # Returns an array of Azure::VirtualMachineDiskManagementService objects
      def list_virtual_machine_disks
        request_path = "/services/disks"
        request = ManagementHttpRequest.new(:get, request_path, nil)
        response = request.call
        Serialization.disks_from_xml(response)
      end

      # Public: Deletes the specified data or operating system disk from the image repository.
      #
      # Returns None
      def delete_virtual_machine_disk(disk_name)
        Loggerx.info "Deleting Disk \"#{disk_name}\". "
        path = "/services/disks/#{disk_name}"
        request = ManagementHttpRequest.new(:delete, path)
        request.call
      end

    end
  end
end

