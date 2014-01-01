require 'spec_helper'

describe Seeders::Cards do
  let(:seeder) { Seeders::Cards }

  it 'seeds cards' do
    previous_count = Card.count
    seeder.seed
    expect(Card.count).to eql(previous_count + 52)
  end

  it 'does not create duplicates' do
    seeder.seed
    count_after_seed = Card.count
    seeder.seed
    expect(Card.count).to eql(count_after_seed)
  end
end
