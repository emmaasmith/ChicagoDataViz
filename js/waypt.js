$( document ).ready(function() {
	var wp1 = new Waypoint({
	  element: $('#s1'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "hidden");
	    $(".mapPlot").css("visibility", "visible");
	    $('#s1').siblings().css("opacity", ".3");
	    $('#s1').css("opacity", "1");
	    colVarRace = 0;
	    colRCW = 0;
	    colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
	    colVar1 = 0;
	    rebuildMap();
	  },
	  offset: '-20%'
	});

	var wp2 = new Waypoint({
	  element: $('#s2'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "hidden");
	    $(".mapPlot").css("visibility", "visible");
	    $('#s2').siblings().css("opacity", ".3");
	    $('#s2').css("opacity", "1");
	    colVarRace = 1;
	    colRCW = 0;
	    colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
	    colVar1 = 0;
	    rebuildMap();
	  },
	  offset: '50%'
	});

	var wp3 = new Waypoint({
	  element: $('#s3'),
	  handler: function(direction) {
	  	$(".scatterPlot").css("visibility", "hidden");
	    $(".mapPlot").css("visibility", "visible");
	    $('#s3').siblings().css("opacity", ".3");
	    $('#s3').css("opacity", "1");
	    colVarRace = 0;
	    colRCW = 1;
	    colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
	    colVar1 = 0;
	    rebuildMap();
	  },
	  offset: '50%'
	});

	var wp4 = new Waypoint({
	  element: $('#s4'),
	  handler: function(direction) {
	  	$(".scatterPlot").css("visibility", "hidden");
	    $(".mapPlot").css("visibility", "visible");
	    $('#s4').siblings().css("opacity", ".3");
	    $('#s4').css("opacity", "1");
	    colVarRace = 0;
	    colRCW = 0;
	    colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
	    colVar1 = 1;
	    colVar = "Emanuel2011_Pct";
	    colDom = [40, 60, 68];
	    rebuildMap();
	  },
	  offset: '50%'
	});

	var wp5 = new Waypoint({
	  element: $('#s5'),
	  handler: function(direction) {
	  	$(".scatterPlot").css("visibility", "hidden");
	    $(".mapPlot").css("visibility", "visible");
	    $('#s5').siblings().css("opacity", ".3");
	    $('#s5').css("opacity", "1");
	    colVarRace = 0;
	    colRCW = 0;
	    colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
	    colVar1 = 0;
	    rebuildMap();
	  },
	  offset: '50%'
	});

	var wp6 = new Waypoint({
	  element: $('#s6'),
	  handler: function(direction) {
	  	$(".scatterPlot").css("visibility", "hidden");
	    $(".mapPlot").css("visibility", "visible");
	    $('#s6').siblings().css("opacity", ".3");
	    $('#s6').css("opacity", "1");
	    colVarRace = 0;
	    colRCW = 0;
	    colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
	    colVar1 = 0;
	    rebuildMap();
	  },
	  offset: '50%'
	});

	var wp7 = new Waypoint({
	  element: $('#s7'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s7').siblings().css("opacity", ".3");
	    $('#s7').css("opacity", "1");
	    xVar = "Rauner";
		xVar2 = "Governor_Votes";
		yVar = "Ob_Obama_Pct";
		yVar2 = "_";
		colVarRace = 1;
		colRCW = 0;
		colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
		colVar1 = 0;
		xDom = [0,1];
		yDom = [0,100];
		xLabelText = "Rauner % (2014)",
		yLabelText = "Obama %, (2012)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp8 = new Waypoint({
	  element: $('#s8'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s8').siblings().css("opacity", ".3");
	    $('#s8').css("opacity", "1");
	    xVar = "Rauner";
		xVar2 = "Governor_Votes";
		yVar = "Emanuel2011_Pct";
		yVar2 = "_";
		colVarRace = 1;
		colRCW = 0;
		colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
		colVar1 = 0;
		xDom = [0,1];
		yDom = [0,100];
		xLabelText = "Rauner % (2014)",
		yLabelText = "Emanuel %, (2011)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp9 = new Waypoint({
	  element: $('#s9'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s9').siblings().css("opacity", ".3");
	    $('#s9').css("opacity", "1");
	    xVar = "Rauner";
		xVar2 = "Governor_Votes";
		yVar = "Emanuel2011_Pct";
		yVar2 = "_";
		colVarRace = 1;
		colRCW = 0;
		colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
		colVar1 = 0;
		xDom = [0,1];
		yDom = [0,100];
		xLabelText = "Rauner % (2014)",
		yLabelText = "Emanuel %, (2011)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp10 = new Waypoint({
	  element: $('#s10'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s10').siblings().css("opacity", ".3");
	    $('#s10').css("opacity", "1");
	    xVar = "Rauner";
		xVar2 = "Governor_Votes";
		yVar = "Emanuel_Pct";
		yVar2 = "_";
		colVarRace = 1;
		colRCW = 0;
		colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
		colVar1 = 0;
		xDom = [0,1];
		yDom = [0,100];
		xLabelText = "Rauner % (2014)",
		yLabelText = "Emanuel %, (2/2015)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp11 = new Waypoint({
	  element: $('#s11'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s11').siblings().css("opacity", ".3");
	    $('#s11').css("opacity", "1");
	    xVar = "Rauner";
		xVar2 = "Governor_Votes";
		yVar = "Run_Emanuel_Pct";
		yVar2 = "_";
		colVarRace = 1;
		colRCW = 0;
		colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
		colVar1 = 0;
		xDom = [0,1];
		yDom = [0,100];
		xLabelText = "Rauner % (2014)",
		yLabelText = "Emanuel %, (4/2015)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp12 = new Waypoint({
	  element: $('#s12'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "hidden");
	    $(".mapPlot").css("visibility", "visible");
	    $('#s12').siblings().css("opacity", ".3");
	    $('#s12').css("opacity", "1");
	    colVarRace = 0;
	    colRCW = 0;
	    colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
	    colVar1 = 0;
	    rebuildMap();
	  },
	  offset: '50%'
	});

	var wp13 = new Waypoint({
	  element: $('#s13'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s13').siblings().css("opacity", ".3");
	    $('#s13').css("opacity", "1");
	    xVar = "Rauner";
		xVar2 = "Governor_Votes";
		yVar = "Run_Emanuel_Pct";
		yVar2 = "_";
		colVarRace = 1;
		colVar1 = 0;
		colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
		xDom = [0,1];
		yDom = [0,100];
		xLabelText = "Rauner % (2014)",
		yLabelText = "Emanuel %, (4/2015)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp14 = new Waypoint({
	  element: $('#s14'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s14').siblings().css("opacity", ".3");
	    $('#s14').css("opacity", "1");
	    xVar = "School_Yes";
		xVar2 = "School_Votes";
		yVar = "Emanuel_Pct";
		yVar2 = "_";
		colVarRace = 1;
		colVar1 = 0;
		colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
		xDom = "[0,1]";
		yDom = "[0,100]";
		xLabelText = "School % (2014)",
		yLabelText = "Emanuel %, (2/2015)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp15 = new Waypoint({
	  element: $('#s15'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s15').siblings().css("opacity", ".3");
	    $('#s15').css("opacity", "1");
	    xVar = "School_Yes";
		xVar2 = "School_Votes";
		yVar = "Emanuel_Pct";
		yVar2 = "_";
		colVarRace = 0;
		colVar1 = 0;
		colSch = 1;
		colNV = 0;
		xDom = "[0,1]";
		yDom = "[0,100]";
		xLabelText = "School % (2014)",
		yLabelText = "Emanuel %, (2/2015)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp16 = new Waypoint({
	  element: $('#s16'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s16').siblings().css("opacity", ".3");
	    $('#s16').css("opacity", "1");
	    xVar = "School_Yes";
		xVar2 = "School_Votes";
		yVar = "Emanuel_Pct";
		yVar2 = "_";
		colVarRace = 0;
		colVar1 = 0;
		colSch = 1;
		colNV = 0;
		colSchNV = 0;
		xDom = "[0,1]";
		yDom = "[0,100]";
		xLabelText = "School % (2014)",
		yLabelText = "Emanuel %, (2/2015)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp17 = new Waypoint({
	  element: $('#s17'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s17').siblings().css("opacity", ".3");
	    $('#s17').css("opacity", "1");
	    xVar = "Emanuel2011_Tot";
		xVar2 = "Overall2011_Tot";
		yVar = "Emanuel_Pct";
		yVar2 = "_";
		colVarRace = 0;
		colVar1 = 0;
		colSch = 0;
	    colNV = 0;
		colSchNV = 1;
		xDom = [0,1];
		yDom = [0,100];
		xLabelText = "Emanuel % (2011)",
		yLabelText = "Emanuel %, (2/2015)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp18 = new Waypoint({
	  element: $('#s18'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s18').siblings().css("opacity", ".3");
	    $('#s18').css("opacity", "1");
	    xVar = "Emanuel2011_Tot";
		xVar2 = "Overall2011_Tot";
		yVar = "Run_Emanuel_Pct";
		yVar2 = "_";
		colVarRace = 0;
		colVar1 = 0;
		colSch = 0;
	    colNV = 0;
		colSchNV = 1;
		xDom = [0,1];
		yDom = [0,100];
		xLabelText = "Emanuel % (2011)",
		yLabelText = "Emanuel %, (4/2015)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp19 = new Waypoint({
	  element: $('#s19'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s19').siblings().css("opacity", ".3");
	    $('#s19').css("opacity", "1");
	    xVar = "Rauner";
		xVar2 = "Governor_Votes";
		yVar = "Ob_Obama_Pct";
		yVar2 = "_";
		colVarRace = 0;
		colVar1 = 0;
		colSch = 0;
	    colNV = 1;
		colSchNV = 0;
		xDom = [0,1];
		yDom = [0,100];
		xLabelText = "Rauner % (2014)",
		yLabelText = "Obama %, (2012)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp20 = new Waypoint({
	  element: $('#s20'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s20').siblings().css("opacity", ".3");
	    $('#s20').css("opacity", "1");
	    xVar = "Votes_Cast";
		xVar2 = "RegVot";
		yVar = "Emanuel_Pct";
		yVar2 = "_";
		colVarRace = 1;
		colVar1 = 0;
		colSch = 0;
	    colNV = 0;
		colSchNV = 0;
		xDom = [0,1];
		yDom = [0,100];
		xLabelText = "Turnout (2/2015)",
		yLabelText = "Emanuel % (2/2015)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp21 = new Waypoint({
	  element: $('#s21'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "visible");
	    $(".mapPlot").css("visibility", "hidden");
	    $('#s21').siblings().css("opacity", ".3");
	    $('#s21').css("opacity", "1");
	    xVar = "Run_Votes_Cast";
		xVar2 = "Run_RegVot";
		yVar = "Run_Emanuel_Pct";
		yVar2 = "_";
		colVarRace = 1;
		colVar1 = 0;
		colSch = 0;
	    colNV = 0;
		colSchNV = 0;
		xDom = [0,1];
		yDom = [0,100];
		xLabelText = "Turnout (4/2015)",
		yLabelText = "Emanuel % (4/2015)";
		rebuildGraph();
	  },
	  offset: '50%'
	});

	var wp22 = new Waypoint({
	  element: $('#s22'),
	  handler: function(direction) {
	    $(".scatterPlot").css("visibility", "hidden");
	    $(".mapPlot").css("visibility", "visible");
	    $('#s22').siblings().css("opacity", ".3");
	    $('#s22').css("opacity", "1");
	    colVarRace = 0;
	    colRCW = 0;
	    colSch = 0;
	    colNV = 0;
	    colSchNV = 0;
	    colVar1 = 0;
	    rebuildMap();
	  },
	  offset: '50%'
	});




	
});