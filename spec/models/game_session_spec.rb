require 'spec_helper'

describe GameSession do
  it {should belong_to(:user)}
  it {should have_many(:cards)}
  it {should have_many(:games)}
  it {should have_many(:decks)}
end
