## kuby-memcached

Memcached plugin for [Kuby](https://github.com/getkuby/kuby-core).

## Intro

The memcached plugin provides the ability to stand up arbitrary memcached instances. Behind the scenes it uses the excellent [kubedb](https://kubedb.com/) Kubernetes operator.

## Configuration

Add the kuby-memcached gem to your Gemfile, then add a memcached instance like this:

```ruby
require 'kuby/memcached'

Kuby.define(:production) do
  kubernetes do

    add_plugin(:memcached) do
      instance(:my_rails_cache)
    end

  end
end
```

The kuby-memcached plugin allows a number of additional configuration options too:

```ruby
Kuby.define(:production) do
  kubernetes do

    add_plugin(:memcached) do
      instance(:my_rails_cache) do
        # set the version of memcached you want to use
        version '1.5.4-v1'  # this is the default version

        # set the port memcached listen on and that you'll
        # use to connect to the instance
        port 11211  # this is the default port
      end
    end

  end
end
```

Get a list of the memcached versions your cluster supports by running:

```bash
bundle exec kuby -e production kubectl -- get memcachedversions
```

## Usage

Memcached instances defined in your Kuby config respond to `#hostname`, `#port`, and `#url` methods to help point at them in your Rails configuration. The `#url` method returns a complete URL to the memcached instance, including the host and port.

### Rails Cache

In your Rails config (eg. config/environments/production.rb), point your cache store at your memcached instance like so:


```ruby
Kuby.load!

url = Kuby.environment.kubernetes
  .plugin(:memcached)
  .instance(:my_rails_cache)
  .url

config.cache_store = :mem_cache_store, url
```

### Dalli

You can also use the [Dalli gem](https://github.com/petergoldstein/dalli) directly:

```ruby
require 'dalli'

url = Kuby.environment.kubernetes
  .plugin(:memcached)
  .instance(:my_rails_cache)
  .url

dc = Dalli::Client.new(url)
dc.set('abc', 123)
value = dc.get('abc')
```

## License

Licensed under the MIT license. See LICENSE for details.

## Authors

* Cameron C. Dutro: http://github.com/camertron
