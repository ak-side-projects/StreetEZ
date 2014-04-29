window.StreetEZ = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $rootEl = $('#content');
    Trellino.boards = new Trellino.Collections.Boards();

    Trellino.boards.fetch({
      success: function () {
        console.log(Trellino.boards)
        new Trellino.Routers.BoardRouter($rootEl);
        Backbone.history.start();
      },
      error: function () {
        console.log('Failed to fetch');
      }
    });
  }
};

// $(document).ready(function(){

// });
