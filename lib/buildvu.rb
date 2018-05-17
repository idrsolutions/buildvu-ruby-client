#--
# Copyright 2018 IDRsolutions
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
#
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#++
#
# Author:: IDRsolutions (mailto:support@idrsolutions.zendesk.com)
# Copyright:: IDRsolutions
# License:: Apache 2.0

require 'JSON'
require 'rest-client'

# Used to interact with IDRsolutions' BuildVu web service
# For detailed usage instructions, see GitHub[https://github.com/idrsolutions/buildvu-ruby-client]
class BuildVu
  @base_endpoint = nil
  @endpoint = nil
  @convert_timeout = nil

  # Constructor, setup the converter details
  # Params:
  # +url+:: string, the URL of the BuildVu web service.
  # +conversion_timeout+:: int, (optional) the time to wait (in seconds) before timing out. Set to 30 by default.
  def initialize(url, conversion_timeout = 30)
    @base_endpoint = url
    @endpoint = @base_endpoint + '/buildvu'
    @convert_timeout = conversion_timeout
  end

  # Converts the given file and returns the URL where the output can be previewed online. If the output_file_path
  # parameter is also passed in, a copy of the output will be downloaded to the specified location.
  # Params:
  # +input_file_path+:: string, the location of the PDF to convert, i.e 'path/to/input.pdf'
  # +output_file_path+:: string, (optional) the directory the output will be saved in, i.e 'path/to/output/dir'
  #
  # Returns: string, the URL where the HTML output can be previewed online
  def convert(input_file_path, output_file_path = nil)
    uuid = upload input_file_path

    response = nil

    # check conversion status once every second until complete or error / timeout
    (0..@convert_timeout).each do |i|
      sleep 1
      response = poll_status uuid

      break if response['state'] == 'processed'

      raise('Server error getting conversion status, see server logs for details') if response['state'] == 'error'

      raise('Failed: File took longer than ' + @convert_timeout.to_s + ' seconds to convert') if i == @convert_timeout
    end

    # download output
    unless output_file_path.nil?
      download_url = @base_endpoint + '/' + response['downloadPath']
      # get filename from input_file_path (downloaded file will be [filename].zip)
      output_file_path += '/' + File.basename(input_file_path)[0..-4] + 'zip'
      download(download_url, output_file_path)
    end

    @base_endpoint + '/' + response['previewPath']
  end

  private

  # Upload file at given path to converter, return UUID if successful
  def upload(input_file_path)
    file = File.open(input_file_path, 'rb')

    begin
      r = RestClient.post(@endpoint, file: file)
    rescue RestClient::ExceptionWithResponse => e
      raise('Error uploading file:\n' + e.message)
    end

    r.code == 200 ? uuid = JSON.parse(r.body)['uuid'] : raise('Error uploading file:\n Server returned response\n' +
                                                                  r.code)

    uuid.nil? ? raise('Error uploading file:\nServer returned null UUID') : uuid
  end

  # Check conversion status
  def poll_status(uuid)
    begin
      r = RestClient.get(@endpoint + '?uuid=' + uuid)
    rescue RestClient::ExceptionWithResponse => e
      raise('Error checking conversion status:\n' + e.to_s)
    end

    r.code == 200 ? response = JSON.parse(r.body) : raise('Error checking conversion status:\n Server returned ' +
                                                              'response\n' + r.code)

    response
  end

  # Download converted output to the given location
  def download(download_url, output_file_path)
    File.open(output_file_path, 'wb') do |output_file|
      block = lambda { |r|
        r.read_body do |data|
          output_file.write data
        end
      }
      RestClient::Request.new(method: :get, url: download_url, block_response: block).execute
    end
  rescue RestClient::ExceptionWithResponse => e
    raise('Error downloading conversion output: ' + e.to_s)
  end
end
