class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, uniqueness: true, case_sensitive: false, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end