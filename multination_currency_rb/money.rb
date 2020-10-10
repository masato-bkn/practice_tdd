# frozen_string_literal: true

require_relative 'sum'

class Money
  attr_accessor :amount, :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def reduce(bank, to)
    rate = bank.rate(@currency, to)
    Money.new(@amount / rate.to_f, to)
  end

  def plus(added)
    Sum.new(self, added)
  end

  def times(multiplier)
    Money.new(amount * multiplier, currency)
  end

  def equal?(other)
    return false unless other.is_a?(Money)

    amount == other.amount && currency == other.currency
  end

  def self.dollar(amount)
    Money.new(amount, 'USD')
  end

  def self.franc(amount)
    Money.new(amount, 'CHF')
  end
end
