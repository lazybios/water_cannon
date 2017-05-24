require "water_cannon/version"

module WaterCannon
  module String
    QUOTE_CHARS = [
      ["「", "‘"],
      ["」", "’"],
      ['『', '“'],
      ['』', '”'],
    ]

    BULLET_CHARS = [
      ['∙', '·'],
      ['•', '·'],
      ['・', '·'],
      ['●', '·'],
      # ['-', '·'], # only in name mode take effect
      ['.', '·'],
      ['．', '·']
    ]

    def shoot!
      # ' foo bar  ' => 'foo bar'
      self.strip!

      # 「」-『』=> '' - ""
      QUOTE_CHARS.each do |chars|
        self.gsub! chars[0], chars[1]
      end

      # 'foo ● bar' => 'foo · bar'
      BULLET_CHARS.each do |chars|
        self.gsub! chars[0], chars[1]
      end

      # remove space between bullet char
      self.gsub! /\s+·\s+/, '·'

      # '“ foo bar ”' => 'foo bar'
      self.gsub! /^["'“‘](.*)[”’"']$/, '\1'

      # replace multiple newlines with a single one:
      self.gsub! /\n\n+/, "\n"

      self.strip
    end
  end
end

String.send :include, WaterCannon::String
