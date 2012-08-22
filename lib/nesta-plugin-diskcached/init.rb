module Nesta
  module Plugin
    module Diskcached
      module Helpers
        # If your plugin needs any helper methods, add them here...
      end
    end
  end

  class App
    helpers Nesta::Plugin::Diskcached::Helpers
  end
end
