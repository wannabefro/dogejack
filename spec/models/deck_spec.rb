require 'spec_helper'

describe Deck do
  it {should belong_to(:game)}
end
