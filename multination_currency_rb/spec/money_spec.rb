# frozen_string_literal: true

require_relative '../dollar'
require_relative '../franc'
require_relative '../money'

RSpec.describe Dollar do
  let :dollar do
    Money.dollar(amount)
  end

  let :amount do
    5
  end

  it '5ドル × 2 = 10ドルとなること' do
    product = dollar.times(2)
    expect(product.amount).to eq 10
  end

  it '同じ金額の通貨であること' do
    expect(Dollar.new(5).equal?(Dollar.new(5))).to eq true
  end

  it 'timeメソッドを呼び出してもdollarが変化しないこと' do
    expect(Dollar.new(10).amount).to eq dollar.times(2).amount
    expect(Dollar.new(15).amount).to eq dollar.times(3).amount
  end
end

RSpec.describe Franc do
  let :franc do
    Money.franc(amount)
  end

  let :amount do
    5
  end

  it '5ドル × 2 = 10ドルとなること' do
    product = franc.times(2)
    expect(product.amount).to eq 10
  end

  it '同じ金額の通貨であること' do
    expect(Franc.new(5).equal?(Franc.new(5))).to eq true
    expect(Franc.new(5).equal?(Money.new(5))).to eq false
  end

  it 'timeメソッドを呼び出してもdollarが変化しないこと' do
    expect(Franc.new(10).amount).to eq franc.times(2).amount
    expect(Franc.new(15).amount).to eq franc.times(3).amount
  end
end
