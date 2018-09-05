require 'buildvu'

buildvu = BuildVu.new'localhost:8080/microservice-example'

# convert returns a URL (string) where you can view the converted output.
output_url = buildvu.convert 'path/to/file.pdf'
# Or alternatively: to upload a url pointing to the server
# output_url = buildvu.convert 'path/to/file.pdf', inputType: "download"
puts 'Converted: ' + output_url

# You can also specify a directory to download the converted output to:
# buildvu.convert('path/to/input.pdf', 'path/to/output/dir')
