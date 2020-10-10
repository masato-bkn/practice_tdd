# frozen_string_literal: true

require_relative '../money'
require_relative '../bank'

RSpec.describe Money do
  shared_context '単一通貨の計算について' do
    let :money do
      Money.dollar(5)
    end

    let :bank do
      Bank.new
    end

    let :currency do
      'USD'
    end

    let :other do
      'CHF'
    end

    it '5 × 2 = 10となること' do
      expect(money.times(2).amount).to eq 10
    end

    it '5 + 5 = 10となること' do
      expect(bank.reduce(money.plus(money), 'USD').amount).to eq(10)
    end

    it '同じ通貨で同じ金額であること' do
      expect(money.equal?(money)).to eq true
    end

    it '金額が異なる場合、異なる通貨であること' do
      expect(money.equal?(Money.new(10, other))).to eq false
    end

    it '通貨単位がcurrencyであること' do
      expect(Money.dollar(1).currency).to eq(currency)
    end
  end

  context 'ドルの場合' do
    include_context '単一通貨の計算について'
  end

  context 'フランの場合' do
    let :currency do
      'CHF'
    end

    include_context '単一通貨の計算について'
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
      'USD'
    end

    let :to do
      'CHF'
    end

    it 'ドル->フランの為替レートが1:2であること' do
      expect(bank.rate(from, to)).to eq(2)
    end

    it 'ドル->フランの為替レートが1:3に変更できること' do
      expect { bank.add_rate(from, to, 3) }.to change { bank.rate(from, to) }.from(2).to(3)
    end
  end

  context '複数通貨の計算について' do
    before :each do
      bank.add_rate(from, to, 2)
    end

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
      Sum.new(dollar, franc)
    end

    let :from do
      'CHF'
    end

    let :to do
      'USD'
    end

    context 'ドルとフランのレートが1:2のとき' do
      it '5ドル + 10フラン = 10ドルとなること' do
        expect(bank.reduce(sum.plus(franc), 'USD').amount).to eq(15)
      end

      it '(5ドル + 10フラン) * 2 = 20ドルとなること' do
        expect(bank.reduce(sum.times(2), 'USD').amount).to eq(20)
      end
    end

    context 'フランとドルのレートが2:1のとき' do
      let :from do
        'USD'
      end

      let :to do
        'CHF'
      end

      it '5ドル + 10フラン + 10フラン = 22.5フランとなること' do
        expect(bank.reduce(sum.plus(franc), 'CHF').amount).to eq(22.5)
      end

      it '(5ドル + 10フラン) * 2 = 20ドルとなること' do
        expect(bank.reduce(sum.times(2), 'CHF').amount).to eq(25)
      end
    end
  end
end
