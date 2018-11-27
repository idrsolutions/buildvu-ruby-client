require 'buildvu'

buildvu = BuildVu.new'localhost:8080/microservice-example'

# convert returns a URL (string) where you can view the converted output.
output_url = buildvu.convert 'path/to/file.pdf'
# Or alternatively: to upload a url pointing to a pdf file with:
# output_url = buildvu.convert 'path/to/file.pdf', input_type: BuildVu::DOWNLOAD

puts 'Converted: ' + output_url

# You can also specify a directory to download the converted output to:
# buildvu.convert('path/to/input.pdf', output_file_path: 'path/to/output/dir')
# 
# Additionally you can specify a URL that you want to be updated when the conversion finishes 
# buildvu.convert('path/to/input.pdf', callback_url: 'http://listener.url')
