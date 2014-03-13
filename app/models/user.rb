class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:recoverable, 
         :rememberable, :trackable, :validatable,
         :lockable, :authentication_keys => [:login]
  attr_accessor :login

  validates :username, :uniqueness => { :case_sensitive => false }

  ROLES = %w[admin]
  ROLES.each do |role|
    define_method("#{role}?") {
      self.role == role
    }
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
