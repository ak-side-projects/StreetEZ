StreetEZ.Views.MessageShow = Backbone.View.extend({

  template: JST['messages/show'],
	
	events: {
	},
	
	initialize: function (options) {
		this.listenTo(this.collection, "add change reset", this.render)
	},
	
	render: function () {
		this.$el.html("");
		var testMsg = this.collection.last();
		var otherUser = {};
		if (parseInt(testMsg.get('sender_id')) === parseInt(StreetEZ.currentUser.get('id'))) {
			otherUser = testMsg.recipient;
		} else {
			otherUser = testMsg.sender;
		}
		
		var renderedContent = this.template({
			messages: this.collection,
			otherUser: otherUser
		});
		this.$el.html(renderedContent);
		
		var $main = this.$el.find('main');
		this.messageFormView = new StreetEZ.Views.MessageForm({
			collection: this.collection,
			otherUser: otherUser
		});
		
		this.messageFormView.options.parent = this;
		$main.prepend(this.messageFormView.render().$el);
			
		return this;
	}

});
