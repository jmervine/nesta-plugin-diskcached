# Nesta::Plugin::Diskcached

### [Documentation](http://jmervine.github.com/nesta-plugin-diskcached/doc/index.html) | [Why?](https://github.com/jmervine/nesta-plugin-diskcached/blob/master/WHY.md) | [NestaCMS.com](http://nestacms.com) | [Diskcached](http://diskcached.rubyops.net/)

A Nesta Plugin for disk cache via diskcached. It is an alternative to using Nesta's built in Sinatra::Cache, which wasn't working quite right for me.

## Installation

Add this line to your application's Gemfile:

    gem 'nesta-plugin-diskcached'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nesta-plugin-diskcached

## Usage

Add optional params to your config/config.yml

    diskcached: true # default
    diskcached_timeout: 3600 # default (in seconds)
    diskcached_dir: /tmp/diskcached 
      # defaults to "Nesta::Env.root/diskcached"
      # 
      # Values added for 'diskcached_dir' should
      # be a full path starting with '/', otherwise
      # Nesta::Env.root will be added to the beginning
      # of the path string.

## Notes

1. This has not been tested with nesta-plugin-simplicity and does
   not include overrides to include cacheing for anything Nesta's
   default renderers, namely:
   - haml
   - erb
2. Currently this creates cache files for everything passed through
   rendering, which mean it creates a lot of extra and unused files.
   Ideally, it would only create a file for the final rendered result.
   It really doesn't hurt performance, but is just a bit ugly.
   

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
