# Placements model

module.exports =
	model:
		'Date': String
		'Campaign': String
		'Site (DFA)': String
		'Placement. Dart Placement Name': String
		'Placement Tactic': String
		'DMP Segment': String
		'MediaCostM':
			type: Number
			default: 0
		'ImpsM':
			type: Number
			default: 0
		'ClicksM':
			type: Number
			default: 0
		'Consumer - Homepage : Learn_Shop_Unique: Click-through Conversions':
			type: Number
			default: 0
		'Consumer - Homepage : Learn_Shop_Unique: View-through Conversions':
			type: Number
			default: 0
		'Consumer - Remarketing : Loop Qual Success_FiOS TV: Click-through Conversions':
			type: Number
			default: 0
		'Consumer - Remarketing : Loop Qual Success_FiOS TV: View-through Conversions':
			type: Number
			default: 0
		'Consumer - Remarketing : Loop Qual Success_FiOS Internet: Click-through Conversions':
			type: Number
			default: 0
		'Consumer - Remarketing : Loop Qual Success_FiOS Internet: View-through Conversions':
			type: Number
			default: 0
		'Consumer - Remarketing : Loop Qual Success_CHSI: Click-through Conversions':
			type: Number
			default: 0
		'Consumer - Remarketing : Loop Qual Success_CHSI: View-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO CHSI Order - AM: Click-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO CHSI Order - AM: View-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO CHSI Order - NC: Click-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO CHSI Order - NC: View-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO FiOS Internet Order - AM: Click-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO FiOS Internet Order - AM: View-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO FiOS Internet Order - NC: Click-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO FiOS Internet Order - NC: View-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO FiOS TV Order - AM: Click-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO FiOS TV Order - AM: View-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO FiOS TV Order - NC: Click-through Conversions':
			type: Number
			default: 0
		'Consumer - Order Confirmation : GO FiOS TV Order - NC: View-through Conversions':
			type: Number
			default: 0
		'Consumer - Homepage : VPM_2013: Click-through Conversions':
			type: Number
			default: 0
		'Consumer - Homepage : VPM_2013: View-through Conversions':
			type: Number
			default: 0
		'GoodVisitsM':
			type: Number
			default: 0
		'CTGoodVisitsM':
			type: Number
			default: 0
		'TVLQSm':
			type: Number
			default: 0
		'CTTVLQSm':
			type: Number
			default: 0
		'Total LQS':
			type: Number
			default: 0
		'TVOrdersM':
			type: Number
			default: 0
		'CTTVOrdersM':
			type: Number
			default: 0
		'Internet Orders':
			type: Number
			default: 0
		'CHSI Orders':
			type: Number
			default: 0
		'Total Orders':
			type: Number
			default: 0
		'Total VisitsM':
			type: Number
			default: 0
		'Mobile/Tablet Tactic': String
	collection: 'media'
	methods: {}
	validators: {}
	virtuals: {}
	hooks:
		pre: {}
		post: {}
