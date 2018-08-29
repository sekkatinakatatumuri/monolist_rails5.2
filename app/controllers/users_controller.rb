class UsersController < ApplicationController
  # ログイン確認事前処理(ApplicationControllerで実装)
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @user = User.find(params[:id])
    # wantとhaveで重複した商品は .uniq とすれば、重複を防げる
    @items = @user.items.uniq
    @count_want = @user.want_items.count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  private

  # strong parameters
  def user_params
    # name, email, password, password_confirmation を許可
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end