# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "rubocop-junit_formatter"
  spec.version       = "0.1"
  spec.authors       = ["Ngan Pham"]
  spec.email         = ["nganpham@gmail.com"]
  spec.summary       = %q{JUnit Formatter for RuboCop}
  spec.homepage      = "https://github.com/ngan/rubocop-junit_formatter"
  spec.license       = "MIT"

  spec.files         = Dir["{lib,spec}/**/*"].select { |f| File.file?(f) } +
                         %w(LICENSE.txt Rakefile README.md)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rubocop", "~> 0.9"
end
