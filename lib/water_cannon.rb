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

      # remove emoji
      strip_emoji(self)
    end

    private

    def strip_emoji(text)
       text = text.force_encoding('utf-8').encode
       clean = ""

       # symbols & pics
       regex = /[\u{1f300}-\u{1f5ff}]/
       clean = text.gsub regex, ""

       # enclosed chars 
       regex = /[\u{2500}-\u{2BEF}]/ # I changed this to exclude chinese char
       clean = clean.gsub regex, ""

       # emoticons
       regex = /[\u{1f600}-\u{1f64f}]/
       clean = clean.gsub regex, ""

       #dingbats
       regex = /[\u{2702}-\u{27b0}]/
       clean = clean.gsub regex, ""
     end
  end
end

String.send :include, WaterCannon::String
