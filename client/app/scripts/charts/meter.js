(function() {
  require(['d3'], function(d3) {
    var chart;
    chart = d3.select("body");
    chart = chart.append("div").attr("class", "h-bar");
    return chart = chart.text('d3 test scripts/charts/meter');
  });

}).call(this);
