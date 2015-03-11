'use strict';
var MhagV2 = window.MhagV2;
var Backbone = window.Backbone;
var JST = window.JST;
var $ = window.$;
var _ = window._;
var console = window.console;
MhagV2.Views.GeneratorMain = Backbone.CompositeView.extend({
	template: JST.generator_main,

	events: {
		'click button.get-sets': 'fetchSets',
		'click button.clear': 'clearList',
		'click button.add-skill': 'addSkill',
		'click button.remove-skill': 'removeSkill'
	},

	addSkill: function(){
		var skillSelect = JST.skill_select();
		$('.skill-selects').append(skillSelect);
	},

	removeSkill: function(){
		$('.skill-selects select:last-child').remove();
	},

	fetchSets: function () {
		var klass = $('select.klass-select')[0].value;
		var gender = $('select.gender-select')[0].value;
		this.clearList();
		var charm = this.makeCharm();
		MhagV2.armorSets.reset();
		var skillSelects = $('select.skill-select');
		var selectedSkills = [];
		_.each(skillSelects, function(){
			if (arguments[0].value !== ''){
				selectedSkills.push(arguments[0].value);
			}
		});
		var currentBannedId = [];
		var currentBanListItems = $('.ban-list td.armor-data');
		currentBanListItems.map(function(){
			currentBannedId.push($(this).data('armor-id'));
		});
		MhagV2.armorSets.fetch(
		{ 
			data: {
				banList: currentBannedId,
				skillSelects: selectedSkills,
				charm: JSON.stringify(charm),
				klass: klass,
				gender: gender
			},
			processData: true
		});
	},

	makeCharm: function (){
		var charm = [];
		var slots = $('select.charm-slots')[0].value;
		slots = parseInt(slots);
		charm.push(slots);
		var skill1 = $('select.skill-tree-select-1')[0].value;
		var skillPoint1 = $('select.skill-point-select-1')[0].value;
		if (skill1 !== '') {
			skill1 = parseInt(skill1);
			skillPoint1 = parseInt(skillPoint1);
			charm.push([skill1, skillPoint1]);
		}

		var skill2 = $('select.skill-tree-select-2')[0].value;
		var skillPoint2 = $('select.skill-point-select-2')[0].value;
		if (skill2 !== '') {
			skill2 = parseInt(skill2);
			skillPoint2 = parseInt(skillPoint2);
			charm.push([skill2, skillPoint2]);
		}
		return charm;
	},

	initialize: function () {
		this.collection.each(this.addArmorSet.bind(this));
		this.listenTo(this.collection, 'add', this.addArmorSet);
		this.listenTo(this.collection, 'sync', this.synced);
	},

	synced: function () {
		console.log('synced');
	},

	clearList: function() {
		var that = this;
		var subviews = this.subviews('.armor-set-index');
		_.each(subviews, function(){
			arguments[0].remove();
		});
	},

	addArmorSet: function (set) {
		var subview = new MhagV2.Views.SetItem({
			model: set
		});
		this.addSubview('.armor-set-index', subview);
	},

	render: function () {
		var content = this.template();
		this.$el.html(content);
		this.attachSubviews();
		return this;
	}
});
