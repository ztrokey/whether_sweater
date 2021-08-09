class User < ApplicationRecord
  before_save :set_api_key

  # before_validation do
  #   (self.email = email.to_s.downcase)
  # end

  validates_presence_of :password_digest, require: true
  validates :email, uniqueness: true, presence: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_secure_password

  def set_api_key
    self.api_key ||= SecureRandom.base64.tr('+/=', 'Qrt')
  end
end
