class BackgroundSerializer
  include JSONAPI::Serializer
  set_type :image
  attributes :image, :credit
end
