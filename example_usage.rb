require 'buildvu'

buildvu = BuildVu.new'localhost:8080/microservice-example'

# convert returns a URL (string) where you can view the converted output.
output_url = buildvu.convert '/path/to/input.pdf'
puts 'Converted: ' + output_url

# You can also specify a directory to download the converted output to:
# buildvu.convert('path/to/input.pdf', 'path/to/output/dir')