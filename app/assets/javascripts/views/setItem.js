'use strict';
var MhagV2 = window.MhagV2;
var Backbone = window.Backbone;
var JST = window.JST;
var $ = window.$;
var _ = window._;
var console = window.console;
MhagV2.Views.SetItem = Backbone.View.extend({
	template: JST.set_item,

	events: {
		'click span.glyphicon-ban-circle':'addToBanList'
	},

	addToBanList: function (event) {
		var armorId = $(event.target).data('armor-id');
		var currentBannedId = [];
		var currentBanListItems = $('.ban-list td.armor-data');
		currentBanListItems.map(function(){
			currentBannedId.push($(this).data('armor-id'));
		});
		console.log(currentBannedId);
		var armorName = $(event.target).data('name');
		var banList = $('.ban-list');
		if ($.inArray(armorId, currentBannedId) === -1) {
			var banListItem = new MhagV2.Views.BanListItem({
				armorId: armorId,
				armorName: armorName
			});
			banList.append(banListItem.render().$el);	
		}
	},

	initialize: function (options){
	},

	render: function () {
		var content = this.template({
			set: this.model
		});
		this.$el.html(content);
		return this;
	}
});