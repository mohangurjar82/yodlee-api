class User < ApplicationRecord
  after_create :set_yodlee_credentials
  before_destroy :remove_from_yodlee

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



