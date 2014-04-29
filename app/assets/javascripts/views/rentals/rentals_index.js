StreetEZ.Views.RentalsIndex = Backbone.View.extend({

  template: JST['rentals/index'],
	
	tagName: 'section',

	className: 'search-results group',
	
	initialize: function () {
		this.listenTo(this.collection, 'add remove change reset', this.render);
	},
	
	events : {
		'submit form': 'search'
	},
	
	render: function () {
		var that = this;
		that.$el.html(that.template({
			rentals: that.collection
		}));
		return this;
	},
	
	search: function(event) {
		event.preventDefault();
		console.log(event);
	}

});
