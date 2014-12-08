require "igrf/model"

module Igrf
  module Models
    class Skater < Model
      def home?
        !!attributes[:home]
      end

      def roster
        parent
      end

      def inspect
        "<#{self.class}: @attributes=#{attributes.select { |key, value| [:away, :home, :name, :number].include?(key) }}>"
      end
    end
  end
end
