require "entraceable/version"
require "entraceable_preference"

module Entraceable
  @preference = Preference.new

  class << self
    attr_accessor :preference

    def logger
      @logger ||= Rails.logger
    end

    def logger=(arg)
      @logger = arg
    end

    def method_missing(method, *args, &block)
      raise NoMethodError.new %q(undefined method `#{method}' for #{preference}:#{preference.class}) unless accept? method
      preference.__send__ method, *args, &block
    end

    private
      def accept?(method)
        %w(default_level default_level= disable enable enabled?).map(&:intern).include? method
      end
  end

  def entraceable(method, tag: nil, level: nil)
    alias_name = alias_name_for method
    send :alias_method, alias_name, method
    class_eval <<-EOS
      def #{method}(*args)
        indent = " " * ((@indent_level ||= 0) * 2)
        level = (#{level.inspect} || Entraceable.default_level).intern
        puts = ->c{Entraceable.logger.tagged(%Q(#{tag})) {Entraceable.logger.send level, indent + c} if Entraceable.enabled?}
        puts.call %Q(#{method} is called with arguments, \#\{args.map(&:inspect).join(", ")\})
        @indent_level += 1
        begin
          send(:#{alias_name}, *args).tap{|result|puts.call %Q(#{method} returns \#\{result\})}
        ensure
          @indent_level -= 1
        end
      end
    EOS
  end

  def distraceable(method)
    alias_name = alias_name_for method
    send :remove_method, method
    send :alias_method, method, alias_name
    send :remove_method, alias_name
  end

  private
    def alias_name_for(method)
      ["original", __id__, method.to_s.sub(/\[\]/, "indexer")].join("_").intern
    end
end

Object.extend Entraceable
