require "water_cannon/version"

module WaterCannon
  module String
    def shoot!
      self.strip
    end
  end
end

String.send :include, WaterCannon::String
