require 'spec_helper'

describe User do
  it {should have_many(:games)}
  it {should validate_presence_of(:username)}
end
