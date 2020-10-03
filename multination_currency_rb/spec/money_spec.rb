# frozen_string_literal: true

# frozen_string_literal: true

require_relative '../dollar'

RSpec.describe Dollar do
  let :dollar do
    Dollar.new(amount)
  end

  let :amount do
    5
  end

  it '5ドル × 2 = 10ドルとなること' do
    dollar.times(2)
    expect(dollar.amount).to eq 10
  end
end
