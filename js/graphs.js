var coVar, xVar, xVar2, yVar, yVar2, colDom, xDom, yDom, xLabelText, yLabelText,
  colVarRace, colVar1, colRCW, colSch, colSchNV, colNV;
xVar = "Rauner";
xVar2 = "Governor_Votes";
yVar = "Ob_Obama_Pct";
yVar2 = "_";
colVarRace = 0;
colVar1 = 0;
colRCW = 0;
colSch = 0;
colSchNV = 0;
colNV = 0;
colVar = "_";
colDom = [20, 45, 80];
xDom = [0,1];
yDom = [0,100];
xLabelText = "X-Axis Label",
yLabelText = "Y-Axis Label";

var width = 600,
    height = 600,
    scatterwidth = 545,
    scatterheight = 550;

var xScale = d3.scale.linear()
  .domain(xDom)
  .range([0, scatterwidth]);
var yScale = d3.scale.linear()
  .domain(yDom)
  .range([scatterheight, 0]);

// Define the axes
var xAxis = d3.svg.axis()
  .scale(xScale)
  .orient("bottom")
  .ticks(10);

var yAxis = d3.svg.axis()
  .scale(yScale)
  .orient("left")
  .ticks(10);

// Create svg 
var scattersvg = d3.select("body .graphplot").append("svg")
    .attr("width", width)
    .attr("height", height);

// Create svg for plot
var scatterg = scattersvg.append("g")
    .attr("class", "scatterPlot");

// Create svg for map
var projection = d3.geo.mercator()
  .scale(68000)
  .center([-87.73212559315068,41.834070633524334])
  .translate([width / 2, height / 2]);

var path = d3.geo.path().projection(projection);
var g = scattersvg.append("g");
var features = g.attr("class","features").append('g')
  .attr("class", "mapPlot");

// Color
var colorScale = d3.scale.linear().domain(colDom).range(["green","yellow","red"]);
var colorFn = d3.scale.linear().domain(colDom).range(["green","yellow","red"]);
function colorRaceFn(w, aa, hsp){
  if(w > aa && w > hsp){
    return "#000000";
  } else if (aa > hsp){
    return "#FF0000";
  } else{
    return "#0000FF";
  }
};
function colorRCWFn(e, g, w){
  if(w > 20){
    return "#FF0000";
  } else if (e > g){
    return "#000000";
  } else{
    return "#0000FF";
  }
};

// function repeatGraph() {
//   xVar = "Votes_Cast";
//   xVar2 = "RegVot";
//   yVar = "Emanuel_Pct";
//   xLabelText = "Turnout (2/2015)",
//   yLabelText = "Emanuel % (2/2015)";
//   setTimeout(rebuildGraph,2000);
//   xVar = "Run_Votes_Cast";
//   xVar2 = "Run_RegVot";
//   yVar = "Run_Emanuel_Pct";
//   xLabelText = "Turnout (4/2015)",
//   yLabelText = "Emanuel % (4/2015)";
//   setTimeout(rebuildGraph,2000);
// }

function rebuildGraph(){
  scatterg.selectAll("g").remove();
  scatterg.selectAll("text").remove();

  scatterg.selectAll(".dot")
    .style("fill", function(d){
        if(colSch){
          var majrace = colorRaceFn(d.C_White_Pct, d.C_AA_Pct, d.C_Hispanic_Pct);
          if(majrace != '#000000'){
            return "rgba(0, 0, 0, 0)";
          }
          var noVote = d.School_Yes / d.School_Votes < .55;
          var closedSch = d.Freq;
          
          if ((noVote == true) && (closedSch > 0)){
            return "#00FF00";
          } else if ((noVote == true)){
            return "#0000FF";
          } else if ((closedSch > 0)){
            return "#FF0000";
          } else{
            return "#000000";
          }
        } else if(colSchNV){
          var noVote = d.School_Yes / d.School_Votes < .55;
          var closedSch = d.Freq;

          if((noVote == false) && (closedSch == 0)){
            return "rgba(0, 0, 0, 0)";
          }
          
          if ((noVote == true)){
            return "#0000FF";
          } else if ((closedSch > 0)){
            return "#FF0000";
          } else{
            return "#000000";
          }
        } else if(colNV){
          var majrace = colorRaceFn(d.C_White_Pct, d.C_AA_Pct, d.C_Hispanic_Pct);
          if(majrace != '#000000'){
            return "rgba(0, 0, 0, 0)";
          }
          var noVote = d.School_Yes / d.School_Votes < .55;
          
          if ((noVote == true)){
            return "#FF0000";
          } else{
            return "#000000";
          }
        }
        return colorRaceFn(d.C_White_Pct, d.C_AA_Pct, d.C_Hispanic_Pct);
      })
    .transition()
    .attr("cx", function(d) {
      var x1 = d[xVar];
      if (isNaN(x1)){
        return 0;
      }
      if (xVar2 != "_"){
        var x2 = d[xVar2];
        if(isNaN(x2) || x2 == 0){
          return 0;
        } else {
          return xScale(x1 / x2);
        }
      }
      return xScale(x1);
    })
    .transition()
    .attr("cy", function(d) {
      var y1 = d[yVar];
      if (isNaN(y1)){
        return 0;
      }
      if (yVar2 != "_"){
        var y2 = d[yVar2];
        if(isNaN(y2) || y2 == 0){
          return 0;
        } else {
          console.log(yScale(y1 / y2));
          return yScale(y1 / y2);
        }
      } 
      return yScale(y1);
    });

  // Axes
  scatterg.append("g")
    .call(xAxis)
    .attr("class", "axis")
    .attr("transform", "translate(40," + (scatterheight + 15) + ")");
  
  scatterg
    .append("text")
    .attr("class", "label")
    .style("text-anchor", "end")
    .text(xLabelText)
    .attr("transform", "translate(" + (scatterwidth + 40) + ", "+ (scatterheight + 15) +")");
    
  scatterg.append("g")
    .call(yAxis)
    .attr("class", "axis")
    .attr("transform", "translate(40,15)")
    .append("text")
    .attr("class", "label")
    .attr("transform", "rotate(-90)")
    .style("text-anchor", "end")
    .text(yLabelText);

  scatterg.append("text")
    .attr("class", "graphtitle")
    .attr("x", (width / 2))
    .attr("y", 20)
    .attr("text-anchor", "middle") 
    .text(function(){
      return yLabelText + " vs. " + xLabelText;
    });

  if(colSchNV){
    scatterg.append("g")
      .append("svg:line")
      .transition()
      .duration(1000)
      .style("stroke", "black")
      .attr("x1", 40)
      .attr("y1", scatterheight+15)
      .attr("x2", scatterwidth+40)
      .attr("y2", 15);
    scatterg.append("g")
      .append("text")
      .attr("x", scatterwidth-20)
      .attr("y", 30)
      .attr("text-anchor", "right")
      .attr("class", "label") 
      .text(function(){
        return "line y = x";
      });
  }
}

function buildGraph(){
  d3.csv("RoughData/PrecinctFinal.csv", function(error, dt) {
    scatterg.selectAll(".dot")
      .data(dt)
      .enter()
      .append("circle")
      .attr("class", "dot")
      .style("fill", function(d){
        return colorRaceFn(d.C_White_Pct, d.C_AA_Pct, d.C_Hispanic_Pct);
      })
      .attr("cx", function(d) {
        if (xVar2 != "_"){
          return xScale(d[xVar] / d[xVar2]);
        }else{
          return xScale(d[xVar]);
        }
      })
      .attr("cy", function(d) {
        if (yVar2 != "_"){
          return yScale(d[yVar] / d[yVar2]);
        }else{
          return yScale(d[yVar]);
        }
      })
      .attr("r", 2)
      .attr("transform", "translate(40,15)");
      // .on("mouseover", function(d) {
      // });
  });

  // Axes
  scatterg.append("g")
    .call(xAxis)
    .attr("class", "axis")
    .attr("transform", "translate(40," + (scatterheight + 15) + ")");
  
  scatterg
    .append("text")
    .attr("class", "label")
    .style("text-anchor", "end")
    .text(xLabelText)
    .attr("transform", "translate(" + (scatterwidth + 40) + ", "+ (scatterheight + 15) +")");
    
  scatterg.append("g")
    .call(yAxis)
    .attr("class", "axis")
    .attr("transform", "translate(40,15)")
    .append("text")
    .attr("class", "label")
    .attr("transform", "rotate(-90)")
    .style("text-anchor", "end")
    .text(yLabelText);

  scatterg.append("text")
    .attr("class", "graphtitle")
    .attr("x", (width / 2))
    .attr("y", 20)
    .attr("text-anchor", "middle") 
    .text(function(){
      return yLabelText + " by " + xLabelText;
    });
};
buildGraph();


function rebuildMap(){
  features.selectAll("path")
    .style("fill", function(d) {
      if(colVarRace){
        return colorRaceFn(d.properties.C_White_Pct, d.properties.C_AA_Pct, d.properties.C_Hispanic_Pct);
      } else if (colVar1){
        return colorScale(d.properties[colVar]);
      } else if(colRCW){
        return colorRCWFn(d.properties.Emanuel_Pct, d.properties.Garcia_Pct, d.properties.Wilson_Pct);
      } else{
        return "#bbb";
      }
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
            .style("fill", function(d) {
              if(colVarRace){
                return colorRaceFn(d.properties.C_White_Pct, d.properties.C_AA_Pct, d.properties.C_Hispanic_Pct);
              } else if (colVar1){
                return colorScale(d.properties[colVar]);
              } else if(colRCW){
                return colorRCWFn(d.properties.Emanuel_Pct, d.properties.Garcia_Pct, d.properties.Wilson_Pct);
              } else{
                return "#bbb";
              }           
            });
          d3.selectAll('.dot[precid="'+precid+'"]')
            .style('stroke-width', '0px');
        });
}

function buildMap(){
  // features.selectAll("path").remove();
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
        if(colVarRace){
          return colorRaceFn(d.properties.C_White_Pct, d.properties.C_AA_Pct, d.properties.C_Hispanic_Pct);
        } else if (colVar1){
          return colorScale(d.properties[colVar]);
        } else if(colRCW){
          return colorRaceFn(d.properties.Emanuel_Pct, d.properties.Garcia_Pct, d.properties.Wilson_Pct);
        } else{
          return "#bbb";
        }
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
            .style("fill", function(d) {
              if(colVarRace){
                return colorRaceFn(d.properties.C_White_Pct, d.properties.C_AA_Pct, d.properties.C_Hispanic_Pct);
              } else if (colVar1){
                return colorScale(d.properties[colVar]);
              } else if(colRCW){
                return colorRaceFn(d.properties.Emanuel_Pct, d.properties.Garcia_Pct, d.properties.Wilson_Pct);
              } else{
                return "#bbb";
              }           
            });
          d3.selectAll('.dot[precid="'+precid+'"]')
            .style('stroke-width', '0px');
        });
      });
}
buildMap();

// Begin with it loaded but hidden