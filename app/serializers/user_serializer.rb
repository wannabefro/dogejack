class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :won, :lost, :tied
end
