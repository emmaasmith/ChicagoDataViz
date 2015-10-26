function setMenus(){
	// Set items in the dropdown menus
	var keysArray;
	d3.csv("RoughData/PrecinctFinal.csv", function(error4, pct) {
		keysArray = Object.keys(pct[0]);
		for (var i = 0; i < keysArray.length; i++) {
			if(keysArray[i] == "Emanuel_Pct"){
				$( "#xMenu" ).append( "<option value='"+keysArray[i]+"' selected>"+keysArray[i]+"</option>" );
				$( "#yMenu" ).append( "<option value='"+keysArray[i]+"'>"+keysArray[i]+"</option>" );
				$( "#cMenu" ).append( "<option value='"+keysArray[i]+"'>"+keysArray[i]+"</option>" );
			} else if(keysArray[i] == "Emanuel2011_Pct"){
				$( "#xMenu" ).append( "<option value='"+keysArray[i]+"'>"+keysArray[i]+"</option>" );
				$( "#yMenu" ).append( "<option value='"+keysArray[i]+"' selected>"+keysArray[i]+"</option>" );
				$( "#cMenu" ).append( "<option value='"+keysArray[i]+"'>"+keysArray[i]+"</option>" );
			} else if(keysArray[i] == "Ob_Obama_Pct"){
				$( "#xMenu" ).append( "<option value='"+keysArray[i]+"'>"+keysArray[i]+"</option>" );
				$( "#yMenu" ).append( "<option value='"+keysArray[i]+"'>"+keysArray[i]+"</option>" );
				$( "#cMenu" ).append( "<option value='"+keysArray[i]+"' selected>"+keysArray[i]+"</option>" );
			} else {
				$( "#xMenu" ).append( "<option value='"+keysArray[i]+"'>"+keysArray[i]+"</option>" );
				$( "#yMenu" ).append( "<option value='"+keysArray[i]+"'>"+keysArray[i]+"</option>" );
				$( "#cMenu" ).append( "<option value='"+keysArray[i]+"'>"+keysArray[i]+"</option>" );
			}
		}
     });
}

function clearMap(){
	dotSchools.selectAll('.lnk').remove();
	features.selectAll('.circ').remove();
	features.selectAll('path').remove();
	scatterg.selectAll(".dot").remove();
	scatterg.selectAll("g").remove();
	//features.selectAll('path').remove();
}

function changeX(){
	clearMap();
	xVar = $("#xMenu").val();
	drawMap();
}

function changeY(){
	clearMap();
	yVar = $("#yMenu").val();
	drawMap();
}

function changeCol(){
	clearMap();
	colorVar = $("#cMenu").val();
	drawMap();
}

$( document ).ready(function() {
	colorVar = "Ob_Obama_Pct";
	xVar = "Emanuel_Pct";
	yVar = "Emanuel2011_Pct";
	colDom = [80, 95, 100];
	xDom = [0,100];
	yDom = [0,100];
	setMenus();
	drawMap();

	$('#domXf').submit(function (e) {
	 	clearMap();
		var loC = $('.xloN').val(),
			hiC = $('.xhiN').val();
		xDom = [loC, hiC];
		drawMap();
		e.preventDefault();
	 	return false;
	});

	$('#domYf').submit(function (e) {
	 	clearMap();
		var loC = $('.yloN').val(),
			hiC = $('.yhiN').val();
		yDom = [loC, hiC];
		drawMap();
		e.preventDefault();
	 	return false;
	});

	$('#domCf').submit(function (e) {
	 	clearMap();
		var loC = $('.cloN').val(),
			midC = $('.cmidN').val(),
			hiC = $('.chiN').val();
		colDom = [loC, midC, hiC];
		drawMap();
		e.preventDefault();
	 	return false;
	});
});