require 'spec_helper'

describe Card do
  it {should have_many(:decks).through(:deck_cards)}
end
