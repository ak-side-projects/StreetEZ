class Api::MessagesController < ApplicationController
  
  def index
    @received_messages = current_user.received_messages.order(updated_at: :desc)
    @sent_messages = current_user.sent_messages.order(updated_at: :desc)
    
    render json: {
      received_messages: @received_messages.to_json,
      sent_messages: @sent_messages.to_json
    }
  end
  
  def show
    @message = Message.find(params[:id])
    recipient_id = @message.recipient_id
    sender_id = @message.sender_id
    message_parties = [sender_id, recipient_id]
    current_user == @message.sender ? @other_user = @message.recipient : @other_user = @message.sender
    @messages = Message.where(recipient_id: message_parties)
                       .where(sender_id: message_parties)
                       .order(updated_at: :desc)
    
   render json: @messages
  end
  
  def create
    @message = current_user.sent_messages.new(message_params)

    if @message.save
      render json: @message
    else
      render json: @message.errors.full_messages, status: 422
    end
  end
  
end