# Business day model

module.exports =
  model:
    "month" : String
    "year" : Number
    "days" : Number
    "holidays" : [String]
  collection: 'business_day'
  methods: {}
  validators: {}
  virtuals: {}
  hooks:
    pre: {}
    post: {}
