# Business days routes

module.exports = (server, db) ->

  # all business days
  server.get '/api/media/business_days', (req, res, next) ->
    db.Business_day.find (err, rslts) ->
      return err if err
      res.send rslts

  # all business days for specific year
  server.get '/api/media/business_days/year/:year', (req, res, next) ->
    db.Business_day.find {year: req.params.year}, (err, rslts) ->
      return err if err
      res.send rslts

  # all business days for specific month
  server.get '/api/media/business_days/year/:year/month/:month', (req, res, next) ->
    db.Business_day.find {year: req.params.year, month: req.params.month}, (err, rslts) ->
      return err if err
      res.send rslts

  # all business days for specific month, regardless of year
  server.get '/api/media/business_days/month/:month', (req, res, next) ->
    db.Business_day.find {month: req.params.month}, (err, rslts) ->
      return err if err
      res.send rslts


  # all holidays since beginning of program
  server.get '/api/media/business_days/holidays', (req, res, next) ->
    db.Business_day.where('holidays').exists().exec (err, rslts) ->
      return err if err
      res.send rslts

  # all business within specified year
  server.get '/api/media/business_days/holidays/year/:year', (req, res, next) ->
    db.Business_day.find({year: req.params.year }).where('holidays').exists().exec (err, rslts) ->
      return err if err
      res.send rslts
