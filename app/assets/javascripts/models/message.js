StreetEZ.Models.Message = Backbone.Model.extend({
	
	rootUrl: '/api/messages',
	
  parse: function (response) {
		if (response["sender"]) {
      this.sender = new StreetEZ.Models.User(response["sender"]);
      delete response["sender"];
    }
		
    if (response["recipient"]) {
      this.recipient = new StreetEZ.Models.User(response["recipient"]);
      delete response["recipient"];
    }
    return response;
  }
	
});
