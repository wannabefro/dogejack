class CardSerializer < ActiveModel::Serializer
  attributes :id, :value, :suit
end
