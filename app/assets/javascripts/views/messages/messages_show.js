StreetEZ.Views.MessageShow = Backbone.View.extend({

  template: JST['messages/show'],
	
	events: {
		// 'click li': 'showPost'
	},
	
	initialize: function (options) {
		// this.listenTo(this.receivedMessages, "add change reset remove", this.render);
		// this.listenTo(this.sentMessages, "add change reset remove", this.render);
	},
	
	render: function () {
		// var renderedContent = this.template({
		// 	messages: StreetEZ.receivedMessages
		// });
		// this.$el.html(renderedContent);
		// return this;
	},

});
