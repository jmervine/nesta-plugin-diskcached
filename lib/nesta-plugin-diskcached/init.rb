# Top level Nesta module.
module Nesta

  # Nesta's Plugin module.
  module Plugin

    # Diskcache Plugin
    module Diskcache

      # Setup diskcached global right off the bat!
      def self.init
        if Nesta::Config.diskcached
          STDOUT.puts Nesta::Config.diskcached_dir
          $diskcached = Diskcached.new(Nesta::Config.diskcached_dir)
        else
          $diskcached = NoDiskcache.new
        end
      end

      # Override Diskcache when turned off without
      # erroring.
      class NoDiskcache
        # Pass threw when Diskcache is off.
        def cache(*args) 
          yield
        end
      end
    end
  end

  # Nesta's existing Overrides for rendering.
  module Overrides

    # Override renderers to include cacheing.
    module Renderers

      # Override haml to include diskcached
      def haml *args
        $diskcached.cache(Digest::SHA1.hexdigest(request.url)) { super(*args) }
      end

      # Override erb to include diskcached
      def erb *args
        $diskcached.cache(Digest::SHA1.hexdigest(request.url)) { super(*args) }
      end

    end
  end

  # Add diskcached configs and setup defaults.
  class Config
    @settings += %w[ diskcached diskcached_dir ]

    # Set default cache usage to true, but read from 
    # config file if present.
    #
    # @param [Boolean] use diskcached?
    def self.diskcached
      from_environment("diskcached") || from_yaml("diskcached") || true
    end

    # Set default diskcached path or read from 
    # config file if present.
    #
    # @param [String] cache store location
    def self.diskcached_dir
      default = File.join(Nesta::Env.root, "diskcached")
      set     = from_environment("diskcached_dir") || from_yaml("diskcached_dir") || default

      case set
      when "/"    # don't allow root -- go go gadget default
        default
      when /^\//  # starting at root is good though
        set
      else        # everything else should start at nesta's root
        File.join(Nesta::Env.root, set)
      end
    end
  end

  # Nesta Page override for purge_cache to include
  # Diskcache.flush
  class Page
    def self.purge_cache 
      @@cache = {}
      $diskcached.flush if $diskcached.respond_to? :flush
    end
  end

  # Setup diskcached global right off the bat!
  class App
    configure do 
      Nesta::Plugin::Diskcache.init

      # ensure caches are empty
      Nesta::Page.purge_cache
    end
  end

end
