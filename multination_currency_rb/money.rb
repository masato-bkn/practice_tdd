# frozen_string_literal: true

class Money
  attr_accessor :amount

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
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

  attr_reader :currency
end
