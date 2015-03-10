'use strict';
var Backbone = window.Backbone;
var MhagV2 = window.MhagV2;
MhagV2.Collections.Sets = Backbone.Collection.extend({
	model: MhagV2.Models.Set,
	url: '/api/sets'
});

MhagV2.armorSets = new MhagV2.Collections.Sets();