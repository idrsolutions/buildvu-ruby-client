require 'buildvu'

buildvu = BuildVu.new'localhost:8080/microservice-example'

# Upload a local file to the BuildVu microservice
# convert() returns a hash with the conversion results.
conversion_results = buildvu.convert input: BuildVu::UPLOAD, file: 'path/to/file.pdf'

# You can specify other parameters for the API as named parameters, for example
# here is the use of the callbackUrl parameter which is a URL that you want to 
# be updated when the conversion finishes. 
# See https://github.com/idrsolutions/buildvu-microservice-example/blob/master/API.md
#conversion_results = buildvu.convert input: BuildVu::UPLOAD, callbackUrl: 'http://listener.url'

# Alternatively, you can specify a url from which the server will download the file to convert.
#conversion_results = buildvu.convert url: 'http://link.to/filename', input: BuildVu::DOWNLOAD

output_url = conversion_results['previewUrl']

# After the conversion you can also specify a directory to download the output to:
#buildvu.download_result conversion_results, 'path/to/output/dir'

puts 'Converted: ' + output_url