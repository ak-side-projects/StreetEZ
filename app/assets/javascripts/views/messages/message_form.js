StreetEZ.Views.MessageForm = Backbone.View.extend({
	
  template: JST['messages/form'],
	
	events: {
		'submit form': 'sendMessage'
	},
	
	initialize: function (options) {
		this.otherUser = options.otherUser;
		this.options = {};
	},
	
	render: function () {
		var renderedContent = this.template({
			otherUser: this.otherUser
		});
		this.$el.html(renderedContent);
		return this;
	},
	
	sendMessage: function(event) {
		event.preventDefault();
		var that = this;
		var $form = $(event.currentTarget);
		var formData = $form.serializeJSON();
		var newMessage = new StreetEZ.Models.Message();
		newMessage.collection = this.collection;
		newMessage.sender = StreetEZ.currentUser;
		newMessage.recipient = this.otherUser;
		newMessage.save(formData, {
			success: function(message) {
				that.collection.add(message);
			}
		});
		$form[0].reset();
	}

});
