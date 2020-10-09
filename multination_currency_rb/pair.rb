# frozen_string_literal: true

class Pair
  attr_reader :from , :to , :rate
  def initialize(from, to, rate)
    @from = from
    @to = to
    @rate = rate
  end
end
