json.array!(messages) do |message|

    json.id "#{message.id}"
    json.body "#{message.body}"
		json.recipient_id "#{message.recipient_id}"
		json.sender_id "#{message.sender_id}"
    json.created_at "#{message.created_at}"

    json.recipient do 
      json.id "#{message.recipient_id}"
      json.name "#{message.recipient.name}"
    end

    json.sender do
      json.id "#{message.sender_id}"
      json.name "#{message.sender.name}"
    end
    
end