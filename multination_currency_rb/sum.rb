# frozen_string_literal: true

class Sum
  attr_accessor :augend, :added

  def initialize(augend, added)
    @augend = augend
    @added = added
  end

  def reduce(to)
    Money.new(augend.amount + added.amount, to)
  end
end
