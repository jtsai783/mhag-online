'use strict';
var MhagV2 = window.MhagV2;
var $ = window.$;
var Backbone = window.Backbone;
window.MhagV2 = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
  	new MhagV2.Routers.Router({
  		$rootEl: $('.container'),
      armorSets: MhagV2.armorSets
  	});
  	Backbone.history.start();
  }
};

$(document).ready(function(){
  MhagV2.initialize();
});
