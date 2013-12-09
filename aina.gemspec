# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','aina','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'aina'
  s.version = Aina::VERSION
  s.author = 'Carles Jove i Buxeda'
  s.email = 'info@joanielena.cat'
  s.homepage = 'http://joanielena.cat'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Code generation for WordPress'
# Add your other files here if you make them
  s.files = Dir['bin/aina'] + Dir['lib/aina/*'] + Dir['templates/*'] + Dir['lib/aina.rb']
  s.require_paths << 'lib'
  s.require_paths << 'templates'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','aina.rdoc']
  s.rdoc_options << '--title' << 'aina' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'aina'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.8.1')
end
