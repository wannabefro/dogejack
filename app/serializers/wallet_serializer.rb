class WalletSerializer < ActiveModel::Serializer
  attributes :id, :balance, :user_id
end
