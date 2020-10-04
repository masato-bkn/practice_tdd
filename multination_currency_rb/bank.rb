# frozen_string_literal: true

require_relative 'sum'

class Bank
  def self.reduce(expression, to)
    expression.reduce(to)
  end
end
