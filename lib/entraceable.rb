require "entraceable/version"

module Entraceable
  def entraceable(method, tag: nil, level: :debug)
    alias_name = alias_name_for method
    class_eval <<-EOS if Rails.env.development?
      alias_method :#{alias_name}, :#{method}
      def #{method}(*args)
        indent = " " * ((@indent_level ||= 0) * 2)
        puts = ->c{Rails.logger.tagged(%Q(#{tag})) {Rails.logger.send :#{level}, indent + c}}
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
    class_eval <<-EOS if Rails.env.development?
      remove_method :#{method}
      alias_method :#{method}, :#{alias_name}
      remove_method :#{alias_name}
    EOS
  end

  private
    def alias_name_for(method)
      ["original", to_s, method.to_s.sub(/\[\]/, "indexer")].join("_").intern
    end
end

Object.extend Entraceable
