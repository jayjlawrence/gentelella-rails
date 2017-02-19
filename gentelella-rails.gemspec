lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gentelella/version'

Gem::Specification.new do |s|
  s.name        = 'gentelella-rails'
  s.version     = Gentelella::VERSION
  s.authors     = ['Michael Lang', 'Jay Lawrence']
  s.email       = %w(mwlang@cybrains.net jayjlawrence70@gmail.com)
  s.homepage    = 'https://github.com/jayjlawrence/gentelella-rails'
  s.summary     = 'Injects the gentelella theme and javascript files into Rails assets pipeline'
  s.description = s.summary
  s.license     = 'MIT'

  s.files = Dir['{assets,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_runtime_dependency 'railties', '>= 4.0'
  s.add_runtime_dependency 'sass-rails', '>= 5.0'

  s.add_development_dependency 'nokogiri'
  s.add_development_dependency 'sqlite3'
end
