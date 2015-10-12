class MessagesController < ApplicationController
  before_action :require_user
  before_action :require_same_user, only: [:index, :show]

  def index
    @number_of_unread_msg    = current_user.num_of_unread_messages
    @number_of_read_msg      = current_user.num_of_read_messages
    @number_of_important_msg = current_user.num_of_important_messages

    case
    when params[:page] == 'unread'    then @messages = current_user.unread_messages.order(created_at: :desc)
    when params[:page] == 'read'      then @messages = current_user.read_messages.order(created_at: :desc)
    when params[:page] == 'important' then @messages = current_user.important_messages.order(created_at: :desc)
    end
  end

  def show
    @message = Message.find(params[:id])
    @friend  = User.find(@message.friend_id)
    @message.update(message_read: true)
  end

  def new
    @friend = User.find(params[:user_id])
    @message = Message.new
  end

  def create
    @message           = Message.new(message_params)
    @message.user_id   = params[:user_id]
    @message.friend_id = current_user.id

    if @message.save
      flash[:success] = 'Message was sent!'
      redirect_to user_messages_path(current_user)
    else
      render :new
    end
  end

  def destroy
    Message.find(params[:id]).destroy
    redirect_to :back
  end

  def important
    message = Message.find(params[:id])
    message.update(important: true, message_read: true)
    redirect_to :back
  end

  def unimportant
    message = Message.find(params[:id])
    message.update(important: false, message_read: true)
    redirect_to :back
  end

  private

  def message_params
    params.require(:message).permit(:title, :content)
  end

end
