class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :set_yodlee_credentials
  before_destroy :remove_from_yodlee
  validates :first_name, :last_name, :business_name, presence: true

  def set_yodlee_credentials
    if Yodlee::Config.register_users
      self.yodlee_username = "user#{id}@your-app-name.com"
      self.yodlee_password = Yodlee::Misc.password_generator
      save!
    end
  end

  def yodlee
    @yodlee ||= Yodlee::User.new(self)
  end

   def add_to_yodlee
    yodlee.register if Yodlee::Config.register_users
  end

  def remove_from_yodlee
    yodlee.destroy if Yodlee::Config.register_users
  end

end



