# frozen_string_literal: true

require_relative '../money'
require_relative '../bank'

RSpec.describe Money do
  context 'ドルの場合' do
    let :dollar do
      Money.dollar(amount)
    end

    let :bank do
      Bank.new
    end

    let :amount do
      5
    end

    let :currency do
      'USD'
    end

    it '5ドル × 2 = 10ドルとなること' do
      expect(dollar.times(2).amount).to eq 10
    end

    it '5ドル + 5ドル = 10ドルとなること' do
      sum = dollar.plus(dollar)
      expect(bank.reduce(sum, 'USD').amount).to eq(10)
    end

    it '同じ通貨で同じ金額であること' do
      expect(dollar.equal?(dollar)).to eq true
    end

    it '金額が異なる場合、異なる金額の通貨であること' do
      expect(dollar.equal?(Money.new(10, currency))).to eq false
    end

    it '通貨が異なる場合、異なる金額の通貨であること' do
      expect(dollar.equal?(Money.new(10, 'CHF'))).to eq false
    end

    it '通貨単位がCHFであること' do
      expect(Money.dollar(1).currency).to eq('USD')
    end

    it 'timeメソッドを呼び出してもdollarが変化しないこと' do
      expect(Money.dollar(10).amount).to eq dollar.times(2).amount
      expect(Money.dollar(15).amount).to eq dollar.times(3).amount
    end
  end

  context 'フランの場合' do
    let :bank do
      Bank.new
    end

    let :franc do
      Money.franc(amount)
    end

    let :amount do
      5
    end

    let :currency do
      'CHF'
    end

    it '5フラン × 2 = 10フランとなること' do
      expect(franc.times(2).amount).to eq 10
    end

    it '5フラン + 5フラン = 10フランとなること' do
      sum = franc.plus(franc)
      expect(bank.reduce(sum, 'CHF').amount).to eq(10)
    end

    it '同じ金額の通貨であること' do
      expect(franc.equal?(Money.new(5, currency))).to eq true
    end

    it '金額が異なる場合、異なる金額の通貨であること' do
      expect(franc.equal?(Money.new(10, currency))).to eq false
    end

    it '通貨が異なる場合、異なる金額の通貨であること' do
      expect(franc.equal?(Money.new(10, 'UDF'))).to eq false
    end

    it '通貨単位がCHFであること' do
      expect(Money.franc(1).currency).to eq('CHF')
    end

    it 'timeメソッドを呼び出してもfrancが変化しないこと' do
      expect(Money.new(10, currency).amount).to eq franc.times(2).amount
      expect(Money.new(15, currency).amount).to eq franc.times(3).amount
    end
  end

  context '為替レートについて' do
    before :each do
      bank.add_rate(from, to, rate)
    end

    let :bank do
      Bank.new
    end

    let :rate do
      2
    end

    let :from do
      "USD"
    end

    let :to do
      "CHF"
    end

    it 'ドル->フランの為替レートが1:2であること'do
      expect(bank.rate(from, to)).to eq(2)
    end

    it 'ドル->フランの為替レートが1:3に変更できること'do
      expect {bank.add_rate(from, to, 3)}.to change{ bank.rate(from, to) }.from(2).to(3)
    end
  end

  context '複数通貨の組み合わせ' do
    let :bank do
      Bank.new
    end

    let :dollar do
      Money.dollar(5)
    end

    let :franc do
      Money.franc(10)
    end

    let :sum do
      Sum.new(dollar, franc).plus(franc)
    end

    let :from do
      "CHF"
    end

    let :to do
      "USD"
    end

    context 'ドルとフランのレートが1:2のとき' do
      before :each do
        bank.add_rate(from, to, 2)
      end

      it '5ドル + 10フラン = 10ドルとなること' do
        expect(bank.reduce(sum, "USD").amount).to eq(15)
      end
    end

    context 'フランとドルのレートが2:1のとき' do
      before :each do
        bank.add_rate(from, to, 2)
      end

      let :from do
        "USD"
      end

      let :to do
        "CHF"
      end

      it '5ドル + 10フラン + 10フラン = 22.5フランとなること' do
        expect(bank.reduce(sum, "CHF").amount).to eq(22.5)
      end
    end
  end
end
