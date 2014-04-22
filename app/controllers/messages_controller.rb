class MessagesController < ApplicationController

  def index
    @received_messages = current_user.received_messages.order(updated_at: :desc)
    @sent_messages = current_user.sent_messages.order(updated_at: :desc)
    render :index
  end

  def show
    @message = Message.find_by(id: params[:id])
    recipient_id = @message.recipient_id
    sender_id = @message.sender_id
    message_parties = [sender_id, recipient_id]
    current_user == @message.sender ? @other_user = @message.recipient : @other_user = @message.sender
    @messages = Message.where(recipient_id: message_parties)
                       .where(sender_id: message_parties)
                       .order(updated_at: :desc)
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
