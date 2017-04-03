require 'rails'

module Entraceable
  class Preference
    attr_accessor :default_level

    def initialize
      @default_level = :debug
      @enabled = Rails.env.development?
    end

    def disable
      @enabled = false
    end

    def enable
      @enabled = true
    end

    def enabled?
      @enabled
    end
  end
end
