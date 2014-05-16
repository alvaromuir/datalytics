(function() {
  var height, path, svg, width;

  width = 960;

  height = 600;

  path = d3.geo.path().projection(null);

  svg = d3.select("body").append("svg").attr("width", width).attr("height", height);

  d3.json("/data/us.json", function(error, us) {
    if (error) {
      return console.error(error);
    }
    svg.append("path").datum(topojson.feature(us, us.objects.nation)).attr("class", "land").attr("d", path);
    svg.append("path").datum(topojson.mesh(us, us.objects.states, function(a, b) {
      return a !== b;
    })).attr("class", "border border--state").attr("d", path);
  });

}).call(this);
