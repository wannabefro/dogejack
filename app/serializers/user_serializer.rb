class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :username, :won, :lost, :tied
  has_many :wallets
end
