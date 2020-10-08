# frozen_string_literal: true

require_relative 'sum'
require_relative 'pair'

class Bank
  attr_accessor :pairs

  def initialize
    @pairs = []
  end

  def self.reduce(expression, to)
    expression.reduce(to)
  end

  def add_rate(from, to, rate)
    @pairs&.reject! { |v| p pair?(v, from, to)} unless @pairs.empty?
    @pairs << Pair.new(from, to, rate)
  end

  def rate(from, to)
    p from
    p to
    @pairs.select { |v| pair?(v, from, to)}.first.rate
  end

  private

  def pair?(pair, from, to)
    pair.from == from && pair.to == to
  end
end
