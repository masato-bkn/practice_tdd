# frozen_string_literal: true

class Money
  attr_accessor :amount

  def initialize(amount)
    @amount = amount
  end

  def time
    raise NotImplementedError
  end

  def equal?(object)
    return false unless object.is_a?(Money)

    amount == object.amount && self.class == object.class
  end
end
