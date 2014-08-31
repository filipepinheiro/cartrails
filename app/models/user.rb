class User < ActiveRecord::Base
  validates :name, :birthdate, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, length: {minimum: 6}

  def init
    self.confirmated = false
  end

  
end
