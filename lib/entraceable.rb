require "entraceable/version"

module Entraceable
  def entraceable(method, tag: nil, level: :debug)
    class_eval <<-EOS if Rails.env.development?
      alias_method :original_#{method}, :#{method}
      def #{method}(*args)
        Rails.logger.tagged(#{tag}) {Rails.logger.send :#{level}, %Q(#{method} is called with arguments, \#\{args\})}
        send(:original_#{method}, *args).tap do |result|
          Rails.logger.tagged(#{tag}) {Rails.logger.send :#{level}, %Q(#{method} returns \#\{result\})}
        end
      end
    EOS
  end

  def distraceable(method)
    class_eval <<-EOS if Rails.env.development?
      remove_method :#{method}
      alias_method :#{method}, :original_#{method}
      remove_method :original_#{method}
    EOS
  end
end

Object.extend Entraceable
