'use strict';
var MhagV2 = window.MhagV2;
var Backbone = window.Backbone;
var $ = window.$;
MhagV2.Routers.Router = Backbone.Router.extend({
	initialize: function (option) {
		this.$rootEl = option.$rootEl;
		this.armorSets = option.armorSets;
	},

	routes: {
		'': 'index'
	},

	index: function () {
		var indexView = new MhagV2.Views.GeneratorMain({
			collection: this.armorSets,
		});
		this._swapView(indexView);
	},

	_swapView: function (view) {
		if (typeof this.currentView !== 'undefined') {
			this.currentView.remove();
		}
		this.currentView = view;
		this.$rootEl.html(view.render().$el);
	},
});