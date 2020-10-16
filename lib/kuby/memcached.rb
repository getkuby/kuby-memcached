require 'kuby'
require 'kuby/memcached/plugin'

module Kuby
  module Memcached
    autoload :Instance, 'kuby/memcached/instance'
  end
end

Kuby.register_plugin(:memcached, Kuby::Memcached::Plugin)
