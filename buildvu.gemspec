lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buildvu/version'

Gem::Specification.new do |spec|
  spec.name          = 'buildvu'
  spec.version       = BuildVu::VERSION
  spec.authors       = ['IDRsolutions']
  spec.email         = ['support@idrsolutions.zendesk.com']
  spec.date          = Time.now.strftime('%Y-%m-%d')

  spec.summary       = 'Ruby API for IDRSolutions BuildVu Microservice'
  spec.description   = "The BuildVu Ruby Client is the Ruby API for IDRsolutions' BuildVu Microservice Example, an open
                        source project that allows you to convert PDF to HTML5 by running BuildVu as an online service.
                        For documentation and usage examples, check out our GitHub page."
  spec.homepage      = 'https://github.com/idrsolutions/buildvu-ruby-client'
  spec.license       = 'Apache-2.0'

  spec.required_ruby_version = '>= 2.0.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rest-client', '~> 2.0', '>= 2.0.2'
  spec.add_runtime_dependency 'json', '~> 2.1', '>= 2.1'
end
