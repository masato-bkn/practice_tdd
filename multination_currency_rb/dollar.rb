# frozen_string_literal: true

require_relative 'money'

class Dollar < Money
  attr_accessor :amount

  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Dollar.new(amount * multiplier)
  end
end
