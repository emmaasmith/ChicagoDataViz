var colorVar, xVar, yVar, colDom, xDom, yDom;

var width = 500,
    height = 600,
    scatterwidth = 500,
    scatterheight = 600;

var svg = d3.select("body .mappost").append("svg")
    .attr("width", width)
    .attr("height", height)
    .attr("class", "mapbody");

var scattersvg = d3.select("body .mappost").append("svg")
    .attr("width", scatterwidth)
    .attr("height", scatterheight);

var projection = d3.geo.mercator()
    .scale(68000)
    .center([-87.73212559315068,41.834070633524334])
    .translate([width / 2, height / 2]);

var path = d3.geo.path().projection(projection);

var g = svg.append("g");
var scatterg = scattersvg.append("g");

var features = g.attr("class","features").append('g');
var arcGroup = g.append('g');
var dotSchools = g.append('g');

// Move to back
d3.selection.prototype.moveToBack = function() { 
    return this.each(function() { 
        var firstChild = this.parentNode.firstChild; 
        if (firstChild) { 
            this.parentNode.insertBefore(this, firstChild); 
        } 
    }); 
};



// Fisher-Yates shuffle
function shuffle(array) {
  var rnd, tmp, ind = array.length;
  while(ind!==0){
    rnd = Math.floor(Math.random() * ind);
    ind--;
    tmp = array[ind];
    array[ind] = array[rnd];
    array[rnd] = tmp;
  }
  return array;
}

// Create the map
function drawMap(){
  var lineTransition, tweenDash, links, pathArcs, key, gradient;

  // Color variables and key
  colorScale = d3.scale.linear().domain(colDom).range(["green","yellow","red"]);
  colorScaleSchool = d3.scale.linear().domain([1,2,3,4,5]).range(["black","white","blue","purple"]);
  colorScaleArrows = d3.scale.linear().domain([-10,15,30,70]).range(["white", "#aaaaaa", "#555555", "black"]);
  containsSchool = d3.scale.linear().domain([0,1,100]).range(["0px","5px","5px"]);

  gradient = svg.append("svg:defs")
    .append("svg:linearGradient")
    .attr("id", "gradient")
    .attr("x1", "0%")
    .attr("y1", "0%")
    .attr("spreadMethod", "pad");

  gradient.append("svg:stop")
      .attr("offset", "0%")
      .attr("stop-color", "green")
      .attr("stop-opacity", 1);

  gradient.append("svg:stop")
      .attr("offset", "50%")
      .attr("stop-color", "yellow")
      .attr("stop-opacity", 1);

  gradient.append("svg:stop")
      .attr("offset", "100%")
      .attr("stop-color", "red")
      .attr("stop-opacity", 1);

  var keyScale = d3.scale.linear()
    .domain(colDom)
    .range([0, 100]);

  var keyAxis = d3.svg.axis()
    .scale(keyScale)
    .orient("bottom")
    .ticks(10)
    .tickSize(10);

  key = scattersvg.append('rect')
    .attr('x', 50)
    .attr('y', 0)
    .attr('width', 100)
    .attr('height', 16)
    .attr('fill', 'url(#gradient)')
    .attr('class', 'colorKey')
    .call(keyAxis);

  // Axes variables
  var x = d3.scale.linear()
    .domain(xDom)
    .range([0, scatterwidth]);
  var y = d3.scale.linear()
    .domain(yDom)
    .range([scatterheight, 0]);

  var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom")
    .ticks(10)
    .tickSize(10);

  var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .ticks(10)
    .tickSize(10);

  // Load data
  d3.json("RoughData/PrecinctFinal.json",function(error,geodata) {
    if (error) return console.log(error); //unknown error, check the console

    // Draw map
    features.selectAll("path")
      .data(topojson.feature(geodata,geodata.objects.PrecinctPtCnt).features) 
      .enter()
      .append("path")
      .attr('class', 'districts')
      .attr("d",path)
      .style("fill", function(d) {
        return colorScale(d.properties[colorVar])
      })
      .attr("precid", function(d) {
        return d.properties.FULL_TEXT;
      })
      .on("mouseover", function(d) {
        var precid = d3.select(this).attr("precid");
        d3.select(this)
          .style("fill", "white");
        d3.selectAll('.dot[precid="'+precid+'"]')
          .style({
            stroke: 'black',
            'stroke-width': '10px'
          });
        d3.select("#precinctBox")
          .select("#SWard")
          .text(d.properties.Ward);
        d3.select("#precinctBox")
          .select("#SPrecinct")
          .text(d.properties.Precinct);
        d3.select("#precinctBox")
          .select("#STot")
          .text(d.properties.Votes_Cast);
        d3.select("#precinctBox")
            .select("#SObama")
            .text(d.properties.Ob_Obama_Pct);
        d3.select("#precinctBox")
          .select("#SEmanuel")
          .text(d.properties.Emanuel_Pct);
        d3.select("#precinctBox")
          .select("#SGarcia")
          .text(d.properties.Garcia_Pct);
        d3.select("#precinctBox")
          .select("#SWilson")
          .text(d.properties.Wilson_Pct);
        d3.select("#precinctBox")
          .select("#SFioretti")
          .text(d.properties.Fioretti_Pct);
        d3.select("#precinctBox")
          .select("#SWalls")
          .text(d.properties.Walls_Pct);
        d3.select("#precinctBox").classed("hidden", false);
        })
        .on("mouseout", function() {
          var precid = d3.select(this).attr("precid");
          d3.select("#precinctBox")
            .classed("hidden", true);
          d3.select(this)
            .style("fill", function(d) {return colorScale(d.properties[colorVar])});

          d3.selectAll('.dot[precid="'+precid+'"]')
            .style('stroke-width', '0px');
        });
  
      // Add dots
      d3.csv("RoughData/SchoolsFinal2.csv", function(error2, schooldata) {
        d3.csv("RoughData/SchoolsLinksFinal.csv", function(error3, linkdata) {
          d3.csv("RoughData/AllSchools.csv", function(error4, allschoolsdata) {

            // Little grey dots for all schools
            dotSchools.selectAll(".lnk")
             .data(allschoolsdata)
             .enter()
             .append("circle")
             .attr("class", ".lnk")
             .style("fill", "#444")
             .attr('d', path)
             .attr("cx", function(d) {
              return projection([d.Longitude, d.Latitude])[0];
             })
             .attr("cy", function(d) {
              return projection([d.Longitude, d.Latitude])[1];
             })
             .attr("r", .5);
          });

          // Schools on map
          features.selectAll(".circ")
            .data(schooldata)
            .enter()
            .append("circle")
            .style("fill", "#ccc")
            .attr("class", ".circ")
            .attr('d', path)
            .attr("cx", function(d) {
              return projection([d.Longitude, d.Latitude])[0];
            })
            .attr("cy", function(d) {
              return projection([d.Longitude, d.Latitude])[1];
            })
            .attr("r", 2)
            .style("stroke", function(d) {
              return colorScaleSchool(d.ResultCode)
            })
            .on("mouseover", function(d) {
              var boxX = d3.select(this).attr("cx");
              var boxY = d3.select(this).attr("cy"); 
              d3.select("#schoolBox")
                .style("left", boxX + "px")
                .style("top", boxY + "px")
                .select("#SName")
                .text(d.OfficialSh);
              d3.select("#schoolBox")
                .select("#SResult")
                .text(d.Impact);
              d3.select("#schoolBox")
                .select("#SPoints")
                .text(Math.round(d.XPerforman * 100) / 100);
              d3.select("#schoolBox")
                .select("#SEnroll")
                .text(d.X20121320t);
              d3.select("#schoolBox")
                .select("#SLowIncome")
                .text(d.X201213Low);
              d3.select("#schoolBox").classed("hidden", false);
            })
            .on("mouseout", function() {
              d3.select("#schoolBox").classed("hidden", true);
            });

          // Lines on map
          lineTransition = function lineTransition(path) {
            path.transition()
            .duration(5500)
            .attrTween("stroke-dasharray", tweenDash)
            .each("end", function(d,i) { 
              svg.append("svg:defs").selectAll("marker")
              .data(["end"])
              .enter().append("svg:marker")
              .attr("id", String)
              .attr("viewBox", "0 -5 10 10")
              .attr("refX", 9)
              .attr("refY", 0)
              .attr("markerWidth", 5)
              .attr("markerHeight", 5)
              .attr("orient", "auto")
              .append("svg:path")
              .attr("d", "M0,-5L10,0L0,5");
            });
          };

          tweenDash = function tweenDash() {
            var len = this.getTotalLength(),
            interpolate = d3.interpolateString("0," + len, len + "," + len);
            return function(t) { 
              return interpolate(t); 
            };
          };

          links = [{ type: "LineString",
                    coordinates: [[linkdata[0].SrcLon, linkdata[0].SrcLat],
                    [linkdata[0].DstLon, linkdata[0].DstLat]]}];
          links = [];
          for(var i=0, len=linkdata.length; i<len; i++){
            links.push({
              type: "LineString",
              coordinates: [
                [ linkdata[i].SrcLon, linkdata[i].SrcLat ],
                [ linkdata[i].DstLon, linkdata[i].DstLat ]]
              });
          }

          pathArcs = arcGroup.selectAll(".arc").data(links);              
          pathArcs.enter()
            .append("path").attr({'class': 'arc'})
            .attr("marker-end", "url(#end)");
          pathArcs.attr({d: path})
            .style({
              stroke: '#000000',
              'stroke-width': '1px'
            })
            .call(lineTransition);
          pathArcs.exit().remove();
        });
      });

      // Draw axes
      scatterg.append("g")
        .call(xAxis)
        .attr("class", "axis")
        .attr("transform", "translate(0," + scatterheight + ")")
        .append("text")
        .attr("class", "label")
        .attr("x", scatterwidth)
        .attr("y", -6)
        .style("text-anchor", "end")
        .text(xVar); //Change to xAxisText

      scatterg.append("g")
        .call(yAxis)
        .attr("class", "axis")
        .append("text")
        .attr("class", "label")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text(yVar);

      // Draw scatterplot
      scatterg.selectAll(".dot")
        .data(shuffle(topojson.feature(geodata,geodata.objects.PrecinctPtCnt).features))
        .enter()
        .append("circle")
        .attr("class", "dot")
        .style("fill", function(d) {return colorScale(d.properties[colorVar])})
        .attr("precid", function(d) {
          return d.properties.FULL_TEXT;
        })
        .attr("cx", function(d) {
          return x(d.properties[xVar]);
        })
        .attr("cy", function(d) {
          return y(d.properties[yVar]);
        })
        .attr("r", 2)
        .on("mouseover", function(d) {
          var precid = d3.select(this).attr("precid");
          d3.select(this)
            .style("fill", "red")
            .style({
              stroke: 'black',
              'stroke-width': '2px'
            });
          d3.selectAll('.districts[precid="'+precid+'"]')
            .style("fill","white");
          d3.select("#precinctBox")
            .select("#SWard")
            .text(d.properties.Ward);
          d3.select("#precinctBox")
            .select("#SPrecinct")
            .text(d.properties.Precinct);
          d3.select("#precinctBox")
            .select("#STot")
            .text(d.properties.Votes_Cast);
          d3.select("#precinctBox")
            .select("#SObama")
            .text(d.properties.Ob_Obama_Pct);
          d3.select("#precinctBox")
            .select("#SEmanuel")
            .text(d.properties.Emanuel_Pct);
          d3.select("#precinctBox")
            .select("#SGarcia")
            .text(d.properties.Garcia_Pct);
          d3.select("#precinctBox")
            .select("#SWilson")
            .text(d.properties.Wilson_Pct);
          d3.select("#precinctBox")
            .select("#SFioretti")
            .text(d.properties.Fioretti_Pct);
          d3.select("#precinctBox")
            .select("#SWalls")
            .text(d.properties.Walls_Pct);
          d3.select("#precinctBox").classed("hidden", false);
        })
        .on("mouseout", function() {
          var precid = d3.select(this).attr("precid");
          d3.select(this)
          .style({
            "fill": function(d) {return colorScale(d.properties[colorVar])},
            "stroke-width": "0px"
          });
          d3.selectAll('.districts[precid="'+precid+'"]')
            .style("fill", function(d) {return colorScale(d.properties[colorVar])});
          d3.select("#precinctBox")
            .classed("hidden", true);
        });
  });
}
drawMap();