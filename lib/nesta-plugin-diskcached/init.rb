# Top level Nesta module.
module Nesta

  # Nesta's Plugin module.
  module Plugin

    # Diskcached Plugin
    module Diskcached

      # Setup diskcached global right off the bat!
      def self.init
        if Nesta::Config.diskcached
          STDOUT.puts Nesta::Config.diskcached_dir
          $diskcached = Diskcached.new(Nesta::Config.diskcached_dir)
        else
          $diskcached = NoDiskcached.new
        end
      end

      # Override Diskcached when turned off without
      # erroring.
      class NoDiskcached
        # Pass threw when Diskcached is off.
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
        $diskcached.cache(args.to_s) { super(args) }
      end

      # Override erb to include diskcached
      def erb *args
        $diskcached.cache(args.to_s) { super(args) }
      end

      # Override scss to include diskcached
      def scss *args
        $diskcached.cache(args.to_s) { super(args) }
      end

      # Override sass to include diskcached
      def sass *args
        $diskcached.cache(args.to_s) { super(args) }
      end

      # Override stylesheet to include diskcached
      def stylesheet *args
        $diskcached.cache(args.to_s) { super(args) }
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
    def diskcached
      if settings.include?("diskcached")
        settings.diskcached
      else
        true
      end
    end

    # Set default diskcached path or read from 
    # config file if present.
    #
    # @param [String] cache store location
    def diskcached_dir
      default = File.join(Nesta::Env.root, "diskcached")
      if settings.include?("diskcached_dir") 

        settings.diskcached_dir = case settings.diskcached_dir
          # don't allow root -- go go gadget default
          when "/"
            default

          # starting at root is good though
          when /^\//
            settings.diskcached_dir

          # everything else should start at nesta's root
          else
            File.join(Nesta::Env.root, settings.diskcached_dir)
          end

      else
        # catch issues with a default
        setings.diskcached_dir = default
      end

      settings.diskcached_dir
    end
  end

  # Nesta Page override for purge_cache to include
  # Diskcached.flush
  class Page
    def self.purge_cache 
      @@cache = {}
      $diskcached.flush if $diskcached.responds_to? :flush
    end
  end

  # Setup diskcached global right off the bat!
  class App
    configure do 
      Nesta::Plugin::Diskcached.init
    end
  end

end
