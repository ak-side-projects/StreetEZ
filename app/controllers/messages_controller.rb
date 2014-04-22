class MessagesController < ApplicationController

  def index
    @received_messages = current_user.received_messages
    @sent_messages = current_user.sent_messages
    render :index
  end

  def show
    @messages = Message.find_by(id: params[:id])
    render :show
  end

  def new
    @message = Message.new
    render :new
  end

  def create
    @message = current_user.sent_messages.new(message_params)

    if @message.save
      redirect_to messages_url
    else
      flash.now[:errors] = @message.errors.full_messages
      render :new
    end
  end

  private
  def message_params
    params.require(:message).permit(:recipient_id, :body)
  end

end
