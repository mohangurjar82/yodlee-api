class YodleeAccountsController < ApplicationController
  before_action :set_yodlee_account, only: [:show, :edit, :update, :destroy]


  def new
    @yodlee_account = YodleeAccount.new
  end

  def edit
  end

  def create
      @yodlee_account = current_user.build_yodlee_account(yodlee_account_params)
    if yodlee_login?
      respond_to do |format|
        if @yodlee_account.save
          format.html { redirect_to edit_yodlee_account_path(@yodlee_account), notice: 'Yodlee account was successfully created.' }
        else
          format.html { render :new }
        end
      end
    else
      redirect_to new_yodlee_account_path , notice: 'Invalid username or password'
    end
  end

  def show
    begin 
      yourCobrandLogin = Yodlee::Config.username
      yourCobrandPassword = Yodlee::Config.password
      yourTestUserLogin = current_user.yodlee_account.username
      yourTestUserPassword = current_user.yodlee_account.password

      cobSession = YodleeNow::CobrandSession.new
      cobSession.login(yourCobrandLogin,yourCobrandPassword)

      yodUser = YodleeNow::User.new
      yodUser.login(yourTestUserLogin,yourTestUserPassword,cobSession.sessionToken)
      #User's Transactions
      yodTxns = YodleeNow::TransactionDetails.new
      yodTxns.search_request(cobSession.sessionToken,yodUser.sessionToken)
      @result = yodTxns.response
      @result = yodTxns.basics
    rescue
      @result = []
    end
  end

  def update
    if yodlee_login?
      respond_to do |format|
        if @yodlee_account.update(yodlee_account_params)
          format.html { redirect_to @yodlee_account, notice: 'Yodlee account was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    else
      redirect_to edit_yodlee_account_path(@yodlee_account), notice: 'Invalid username or password'
    end
  end

  private
    def set_yodlee_account
      @yodlee_account = YodleeAccount.find(params[:id])
    end

    def yodlee_account_params
      params.require(:yodlee_account).permit(:username, :password)
    end

    def yodlee_login?
      your_cobrand_login = Yodlee::Config.username 
      your_cobrand_password = Yodlee::Config.password
      # account_id = "10010352"
      cobSession = YodleeNow::CobrandSession.new
      cobSession.login(your_cobrand_login,your_cobrand_password)
      yodUser = YodleeNow::User.new
      yodUser.login(params[:yodlee_account][:username],params[:yodlee_account][:password],cobSession.sessionToken)
    end
end
