'use strict';
var MhagV2 = window.MhagV2;
var Backbone = window.Backbone;
var JST = window.JST;
var $ = window.$;
var _ = window._;
MhagV2.Views.BanListItem = Backbone.View.extend({
	tagName: 'tr',

	template: JST.ban_list_item,

	events: {
		'click span.remove-banItem':'removeBanItem'
	},

	removeBanItem: function(){
		this.remove();
	},

	initialize: function (options) {
		this.armorId = options.armorId;
		this.armorName = options.armorName;
	},

	render: function () {
		var content = this.template({
			armorId: this.armorId,
			armorName: this.armorName
		});
		this.$el.html(content);
		return this;
	}
});