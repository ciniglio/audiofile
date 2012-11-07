# -*- encoding: utf-8 -*-
require File.expand_path('../lib/audiofile/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alejandro Ciniglio"]
  gem.email         = ["mail@alejandrociniglio.com"]
  gem.description   = %q{Gem to parse Audio files and provide
samples as a string of bytes}
  gem.summary       = %q{Gem to parse .Wav files}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "audiofile"
  gem.require_paths = ["lib"]
  gem.version       = Audiofile::VERSION
end
