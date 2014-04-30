StreetEZ.Routers.Messages = Backbone.Router.extend({
	
	initialize: function (options) {
		console.log('instantiating router')
		// this.$rootEl = options.$rootEl
		this.$rootEl = $("#messages-index");
	},
	
	routes: {
		'': 'messagesIndex',
		':id': 'messageShow'
	},
	
	messagesIndex: function () {
		console.log('about to make view');
		this.$rootEl.html("");
		var messagesIndexView = new StreetEZ.Views.MessagesIndex();
		this._swapView(messagesIndexView);
	},
	
	messageShow: function (id) {
		console.log('switch view to show');
		var that = this;
		this._getConversation(id, function(convoMessages) {
			var messageShowView = new StreetEZ.Views.MessageShow({
				collection: convoMessages
			});
			that._swapView(messageShowView);
		});
	},
	
	_getConversation: function (messageID, callback) {
		console.log('inside function')
		var message = StreetEZ.messages.get(messageID);
		console.log('message', message);
		var recipient = message.recipient
		var sender = message.sender
		var conversation = this._filterMessages([recipient.get('id'), sender.get('id')], callback);
	},
	
	_filterMessages: function(parties_arr, callback) {
		console.log('filtering...');
		var filtered = StreetEZ.messages.filter(function(message) {
			if ((parties_arr.indexOf(message.get('recipient_id')) != -1) && (parties_arr.indexOf(message.get('sender_id')) != -1)) {
				return true;
			} else {
				return false;
			}
		});
		var conversation = new StreetEZ.Collections.Messages(filtered);
		callback(conversation);
	},
	
  _swapView: function (view) {
		this._currentView && this._currentView.remove();
		this._currentView = view;
		this.$rootEl.html(view.render().$el);
   }

});
