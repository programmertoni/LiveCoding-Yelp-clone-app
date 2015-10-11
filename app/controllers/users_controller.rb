class UsersController < ApplicationController
  before_action :require_user,      except: [:new, :create]
  before_action :require_same_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success]   = "Welcome #{@user.full_name.titleize}! You are now logged in!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params_without_role)
      flash[:success] = "You've successfuly updated you're account settings."
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  def reviews
    @user    = User.find(params[:id])
    @reviews = @user.reviews
  end

  def my_friends
    @num_of_friends         = current_user.num_of_friends
    @num_of_pending_friends = current_user.num_of_pending_friends
    @num_of_blocked_friends = current_user.num_of_blocked_friends

    case
    when params[:friends] == 'all'     then @friends         = current_user.all_friends
    when params[:friends] == 'pending' then @pending_friends = current_user.pending_friends
    when params[:friends] == 'blocked' then @blocked_friends = current_user.blocked_friends
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :password, :role)
  end

  def user_params_without_role
    params.require(:user).permit(:full_name, :password)
  end

end
