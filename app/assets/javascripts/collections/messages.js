StreetEZ.Collections.Messages = Backbone.Collection.extend({
	
	url: '/api/messages',
	
  model: StreetEZ.Models.Message,
	
	comparator: function(message) {
		return -1 * new Date(message.get('created_at'));
	}
	
});
