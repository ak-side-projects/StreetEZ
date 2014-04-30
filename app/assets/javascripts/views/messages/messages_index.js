StreetEZ.Views.MessagesIndex = Backbone.View.extend({

  template: JST['messages/index'],
	
	events: {
		// 'click .message': 'showMessage'
	},
	
	initialize: function () {
		// this.listenTo(this.receivedMessages, "add change reset remove", this.render);
		// this.listenTo(this.sentMessages, "add change reset remove", this.render);
	},
	
	render: function () {
		var renderedContent = this.template({
			receivedMessages: StreetEZ.messages.where({recipient_id: StreetEZ.currentUser.id.toString()}),
			sentMessages: StreetEZ.messages.where({sender_id: StreetEZ.currentUser.id.toString()})
		});
		this.$el.html(renderedContent);
		return this;
	}

});
