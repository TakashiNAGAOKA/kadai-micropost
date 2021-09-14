class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]

  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 25)
  end

  def show
    @user = User.find(params[:id])
    @pagy, @microposts = pagy(@user.microposts.order(id: :desc))
    counts(@user)
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

  def followings
    @user = User.find(params[:id])
    @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end
  
  def likes
    # likesの定義、メソッドが定義されていないエラー
    # user.rbのモデルで定義する ??
    # 中身のmicropostが変！(followingsと同じような記述になるはず)
    # 課題１：likes.html.erbに渡すインスタンスの生成（お気に入りのインスタンス）、
    # 課題２：pagyで表示するmicropostのインスタンス（課題１と一緒？）
    # paramsのidはセッションから取れるユーザのid
    @user = User.find(params[:id])
    @pagy, @favorings = pagy(@user.favorings)
    counts(@user)
#    self.favorings.where(micropost_id: self.favorings_ids )
#    @likes = Micropost.where(micropost_id: self.likes)
#    @pagy, @likes = pagy(@likes.content)
#    counts(@likes)
#    @favorings = Favorite.find_by_user_id(user_id: params[:id])
#    @pagy, @likes = pagy(@favorings.likes)
#    counts(@favorings)
#    @likes = Like.find_by(user_id: @user.id)
#    @microposts = @likes.micropost.paginate(page: params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
