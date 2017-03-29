require "entraceable/version"

module Entraceable
  def entraceable(method, tag: nil, level: :debug)
    alias_name = Entraceable.alias_name_for method
    class_eval <<-EOS if Rails.env.development?
      alias_method :#{alias_name}, :#{method}
      def #{method}(*args)
        indent = " " * ((@indent_level ||= 0) * 2)
        puts = ->c{Rails.logger.tagged(%Q(#{tag})) {Rails.logger.send :#{level}, indent + c}}
        puts.call %Q(#{method} is called with arguments, \#\{args\})
        @indent_level += 1
        send(:#{alias_name}, *args).tap do |result|
          @indent_level -= 1
          puts.call %Q(#{method} returns \#\{result\})
        end
      end
    EOS
  end

  def distraceable(method)
    alias_name = Entraceable.alias_name_for method
    class_eval <<-EOS if Rails.env.development?
      remove_method :#{method}
      alias_method :#{method}, :#{alias_name}
      remove_method :#{alias_name}
    EOS
  end

  private
    def self.alias_name_for(method)
      ["original", method.to_s.sub(/\[\]/, "indexer")].join("_").intern
    end
end

Object.extend Entraceable
