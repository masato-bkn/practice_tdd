# frozen_string_literal: true

#require_relative 'dollar'
#require_relative 'franc'

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

  # ファクトリーメソッドでサブクラスの存在を隠した
  def self.dollar(amount)
    Dollar.new(amount)
  end

  def self.franc(amount)
    Franc.new(amount)
  end
end
