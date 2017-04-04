require "spec_helper"

class MyLogger
  Levels = %w(debug info warn error fatal unknown).map(&:intern).freeze

  def accept?(method)
    Levels.include? method
  end

  def content
    @content ||= Levels.map{|lv|[lv, []]}.to_h
  end

  def method_missing(method, *args, &block)
    raise NoMethodError.new(%q(undefined method `#{method}')) unless accept? method
    content[method] << args.first
  end

  def tagged(tag, &block)
    yield block
  end

  private :accept?
end

class Example
  attr_accessor :value

  def initialize(value = 0)
    @value = value
  end

  def add(arg)
    value + arg
  end

  entraceable :add
end

describe Entraceable do
  it "has a version number" do
    expect(Entraceable::VERSION).not_to be nil
  end

  it "does something useful" do
    Entraceable.logger = x = MyLogger.new
    e = Example.new [1, 1, 4]
    expect(e.add [5, 1, 4]).to eq([1, 1, 4, 5, 1, 4])
    expect(e.value).to eq([1, 1, 4])
    expect(x.content[:debug].count).to eq(2)
    expect(x.content[:debug].first).to eq("add is called with arguments, [5, 1, 4]")
    expect(x.content[:debug].last).to eq("add returns [1, 1, 4, 5, 1, 4]")
  end
end
