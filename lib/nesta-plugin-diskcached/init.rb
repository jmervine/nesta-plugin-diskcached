module Nesta
  module Overrides
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
      if settings.include?("diskcached_dir")
        unless settings.diskcached_dir =~ /^\//
          settings.diskcached_dir = File.join(Env.root, settings.diskcached_dir)
        end
        settings.diskcached_dir
      else
        File.join(Env.root, "diskcached")
      end
    end
  end

  class App
    # Setup diskcached global right off the bat!
    configure do
      if Config.diskcached
        $diskcached = Diskcached.new(Config.diskcache_dir)
      else
        $diskcached = NoDiskcached.new
      end
    end
  end

  # Override Diskcached when turned off without
  # erroring.
  class NoDiskcached
    # Pass threw when Diskcached is off.
    def cache(*args) do
      yield
    end
  end
end
