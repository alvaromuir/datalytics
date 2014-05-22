
require ['d3'], (d3) ->

  chart = d3.select("body")
  chart = chart.append("div").attr("class", "h-bar")
  chart = chart.text('d3 test scripts/charts/meter')
