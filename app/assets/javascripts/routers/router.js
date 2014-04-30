StreetEZ.Routers.Router = Backbone.Router.extend({
	
	initialize: function (options) {
		this.$rootEl = options.$rootEl
	},
	
	routes: {
		'': 'messagesIndex',
		'messages': 'messagesIndex',
		'mesages/:id': 'messageShow'
	},
	
	messagesIndex: function () {
		this.$rootEl.html("");
		var messagesIndexView = new StreetEZ.Views.MessagesIndex();
		this._swapView(messagesIndexView);
	},
	
	messageShow: function (id) {
		console.log('switch view to show');
		var that = this;
		this._getMessage(id, function(message) {
			var messageShowView = new StreetEZ.Views.MessageShow({
				collection: messages
			});
			that._swapView(messageShowView);
		});
	},
	
	_getMessage: function (id, callback) {
		var message = StreetEZ.messages.get(id);
		if (!message) {
			var message = new StreetEZ.Models.Message({
				id: id
			});
			message.fetch({
				success: function(message) {
					StreetEZ.messages.add(message);
					callback(message);
				}
			});
		} else {
			callback(message);
		}
	},
	
  _swapView: function (view) {
		this._currentView && this._currentView.remove();
		this._currentView = view;
		this.$rootEl.html(view.render().$el);
   }

});
