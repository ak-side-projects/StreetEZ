StreetEZ.Views.MessageShow = Backbone.View.extend({

  template: JST['messages/show'],
	
	events: {
		'click .send-message': 'sendMessage'
	},
	
	initialize: function (options) {
		this.listenTo(this.collection, "add change reset", this.render)
	},
	
	render: function () {
		var testMsg = this.collection.first();
		var otherUser = {};
		testMsg.get('sender_id') === StreetEZ.currentUser.get('id') ? otherUser = testMsg.recipient : otherUser = testMsg.sender
		var renderedContent = this.template({
			messages: this.collection,
			otherUser: otherUser
		});

		this.$el.html(renderedContent);
		return this;
	},
	
	sendMessage: function(event) {
		event.preventDefault();
		console.log('cT', event.currentTarget)
		console.log('target', event.target)
	}

});
