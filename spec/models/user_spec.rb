require 'spec_helper'

describe User do
  it {should have_many(:games)}
  it {should validate_presence_of(:username)}
  it {should have_many(:wallets)}
  
  context 'wallet' do
    it 'should create a wallet after creation' do
      wallet_count = Wallet.count
      user = FactoryGirl.create(:user)
      expect(wallet_count).to eql(wallet_count + 1)
      expect(user.wallet.balance).to eql(500)
    end
  end
end
