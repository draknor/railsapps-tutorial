class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at, :opt_in
  attr_accessible :role_ids, :as => :admin

  # attr_accessible :title, :body

  # override Devise method
  # no password is required when the account is created; validate password when user sets one
  validates_confirmation_of :password
  def password_required?
    if !persisted?
      !(password != "")
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

  # override Devise method - don't confirm at sign-up
  def confirmation_required?
    false
  end

  # override Devise method - don't make accounts active until we later confirm
  def active_for_authentication? 
    confirmed? || confirmation_period_valid?
  end

  private

  def send_welcome_email
    unless self.email.include?('@example.com') && Rails.env != 'test' #prevent sending emails to our fake addresses when running rake db:reset -- only do it when we are running a test
      UserMailer.welcome_email(self).deliver
    end
  end

end
