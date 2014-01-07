class Wallet < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :user_id
  validates_presence_of :user_id, :balance
end
