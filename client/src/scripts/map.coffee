width = 960
height = 600
path = d3.geo.path().projection(null)
svg = d3.select("body").append("svg").attr("width", width).attr("height", height)
d3.json "/data/us.json", (error, us) ->
  return console.error(error)  if error
  svg.append("path").datum(topojson.feature(us, us.objects.nation)).attr("class", "land").attr "d", path
  svg.append("path").datum(topojson.mesh(us, us.objects.states, (a, b) ->
    a isnt b
  )).attr("class", "border border--state").attr "d", path
  return
