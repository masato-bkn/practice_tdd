# frozen_string_literal: true

class Franc
  attr_accessor :amount

  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Franc.new(amount * multiplier)
  end

  def equals(object)
    return false unless object.is_a?(Franc)
    amount == object.amount
  end
end
