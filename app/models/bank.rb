class Bank < ApplicationRecord

	 def yodlee
    @yodlee ||= Yodlee::Bank.new(self)
  	end

end
