$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'kuby/memcached/version'

Gem::Specification.new do |s|
  s.name     = 'kuby-memcached'
  s.version  = ::Kuby::Memcached::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/getkuby/kuby-memcached'

  s.description = s.summary = 'Memcached plugin for Kuby.'

  s.platform = Gem::Platform::RUBY

  s.add_dependency 'kuby-kube-db', '~> 0.4'
  s.add_dependency 'kube-dsl', '~> 0.4'

  s.require_path = 'lib'
  s.files = Dir['{lib,spec}/**/*', 'Gemfile', 'LICENSE', 'CHANGELOG.md', 'README.md', 'Rakefile', 'kuby-memcached.gemspec']
end
