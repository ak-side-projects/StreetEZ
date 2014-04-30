StreetEZ.Views.MessagesIndex = Backbone.View.extend({

  template: JST['messages/index'],
	
	events: {
		'click li': 'showPost'
	},
	
	initialize: function (options) {
		// this.listenTo(this.receivedMessages, "add change reset remove", this.render);
		// this.listenTo(this.sentMessages, "add change reset remove", this.render);
	},
	
	render: function () {
		var renderedContent = this.template({
			receivedMessages: StreetEZ.receivedMessages,
			sentMessages: StreetEZ.sentMessages
		});
		this.$el.html(renderedContent);
		return this;
	},

});
