StreetEZ.Routers.Messages = Backbone.Router.extend({
	
	initialize: function (options) {
		this.$rootEl = $("#messages-index");
	},
	
	routes: {
		'': 'messagesIndex',
		':id': 'messageShow'
	},
	
	messagesIndex: function () {
		this.$rootEl.html("");
		var messagesIndexView = new StreetEZ.Views.MessagesIndex();
		this._swapView(messagesIndexView);
	},
	
	messageShow: function (id) {
		var that = this;
		this._getConversation(id, function(convoMessages) {
			var messageShowView = new StreetEZ.Views.MessageShow({
				collection: convoMessages
			});
			that._swapView(messageShowView);
		});
	},
	
	_getConversation: function (messageID, callback) {
		var message = StreetEZ.messages.get(messageID);
		var recipient = message.recipient
		var sender = message.sender
		var conversation = this._filterMessages([recipient.get('id'), sender.get('id')], callback);
	},
	
	_filterMessages: function(parties_arr, callback) {
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
