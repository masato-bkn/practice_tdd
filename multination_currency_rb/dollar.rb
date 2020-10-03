# frozen_string_literal: true

class Dollar
  attr_accessor :amount

  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Dollar.new(amount * multiplier)
  end

  def equals(object)
    return false unless object.is_a?(Dollar)
    amount == object.amount
  end
end
