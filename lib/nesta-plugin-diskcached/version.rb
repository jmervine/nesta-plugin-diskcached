# Top level Nesta module.
module Nesta

  # Nesta's Plugin module.
  module Plugin

    # Diskcached Plugin, which doesn't really exists
    # as everything is done as overrides. I'm keeping
    # it for Nesta's plugin interface compatability.
    module Diskcached
      # Version for gem building.
      VERSION = "0.0.1"
    end
  end
end
