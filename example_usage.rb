require 'buildvu.rb'
#require 'buildvu'

#buildvu = BuildVu.new'localhost:8080/microservice-example'
buildvu = BuildVu.new'localhost:8080/buildvu'

# convert returns a URL (string) where you can view the converted output.
#output_url = buildvu.convert 'path/to/file.pdf'
# Or alternatively: to upload a url pointing to a pdf file with:
# output_url = buildvu.convert 'path/to/file.pdf', input_type: BuildVu::DOWNLOAD
output_url = buildvu.convert 'https://javaee.github.io/glassfish/doc/5.0/quick-start-guide.pdf', input_type: BuildVu::DOWNLOAD, callback_url: 'http://localhost/listener/'
puts 'Converted: ' + output_url

# You can also specify a directory to download the converted output to:
# buildvu.convert('path/to/input.pdf', output_file_path: 'path/to/output/dir')
