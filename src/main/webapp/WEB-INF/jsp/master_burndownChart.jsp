<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<script type="text/javascript">
	function CreateSampleChart(sprintName) {
		var xAxisData = new Array();
		for (var i = 1; i < 11; i++) {
			xAxisData[i] = '' + i;
		}

		var max = 200;
		var idealRemaining = new Array();
		var i = 0;
		for (; i < xAxisData.length; i++) {
			var remain = parseInt(max * (xAxisData.length - i)
					/ xAxisData.length);
			idealRemaining.push({
				x : i,
				y : remain
			});
		}
		idealRemaining.push({
			x : i,
			y : 0
		});

		var actualData = [ 200, 175, 150, 180, 130 ];
		var actualRemaining = new Array();
		for (var i = 0; i < actualData.length; i++) {
			actualRemaining.push({
				x : i,
				y : actualData[i]
			});
		}

		var velocityData = [ 0, 25, 25, 25, 50 ];
		var velocity = new Array();
		for (var i = 0; i < velocityData.length; i++) {
			velocity.push({
				x : i,
				y : velocityData[i]
			});
		}

		$('#chart').highcharts({
			title : {
				text : 'Sprint Progress',
				x : -20
			},
			subtitle : {
				text : 'Automatically Collected',
				x : -20
			},
			xAxis : {
				categories : xAxisData
			},
			yAxis : {
				title : {
					text : 'Hours'
				},
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#808080'
				} ]
			},
			tooltip : {
				valueSuffix : 'hours'
			},
			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle',
				borderWidth : 0
			},
			series : [ {
				name : 'Actual Task Remaining',
				data : actualRemaining
			}, {
				name : 'Velocity',
				data : velocity
			}, {
				name : 'Ideal Task Remaining',
				data : idealRemaining,
				dashStyle : 'dash'
			} ]
		});
		var chart = $('#chart').highcharts();
		chart.setTitle({
			text : sprintName
		});
	}
	function DrawChart(sprintName, data) {
		var obj = JSON.parse(data);
		//alert(obj.BDChartData['duration'].length);
		//alert(obj.BDChartData['idealRemaining'].length);

		var xAxisData = new Array();
		for (var i = 0; i < obj.BDChartData['duration'].length; i++) {
			xAxisData[i] = '' + obj.BDChartData['duration'][i].value;
		}

		var max = 200;
		var idealRemaining = new Array();
		var i = 0;
		for (; i < xAxisData.length; i++) {
			//var remain = parseInt(max * (xAxisData.length - i) / xAxisData.length);
			idealRemaining.push({
				x : i,
				y : obj.BDChartData['idealRemaining'][i].value
			});
		}
		//idealRemaining.push({x: i, y: obj.BDChartData['idealRemaining'][i].value});

		var actualRemaining = new Array();
		for (var i = 0; i < obj.BDChartData['actualRemaining'].length; i++) {
			actualRemaining.push({
				x : i,
				y : obj.BDChartData['actualRemaining'][i].value
			});
		}

		var velocity = new Array();
		for (var i = 0; i < obj.BDChartData['velocity'].length; i++) {
			velocity.push({
				x : i,
				y : obj.BDChartData['velocity'][i].value
			});
		}

		$('#chart').highcharts({
			title : {
				text : 'Sprint Progress',
				x : -20
			},
			subtitle : {
				text : 'Automatically Collected',
				x : -20
			},
			xAxis : {
				categories : xAxisData
			},
			yAxis : {
				title : {
					text : 'Hours'
				},
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#808080'
				} ]
			},
			tooltip : {
				valueSuffix : 'hours'
			},
			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle',
				borderWidth : 0
			},
			series : [ {
				name : 'Actual Task Remaining',
				data : actualRemaining
			}, {
				name : 'Velocity',
				data : velocity
			}, {
				name : 'Ideal Task Remaining',
				data : idealRemaining,
				dashStyle : 'dash'
			} ]
		});
		var chart = $('#chart').highcharts();
		chart.setTitle({
			text : sprintName
		});

	}
	function OnChange() {
		var myselect = document.getElementById("selectOpt");
		//alert(myselect.options[myselect.selectedIndex].value);
		//
		var request = myselect.options[myselect.selectedIndex].value;
		$.ajax({
					type : "POST",
					contentType : "application/json",
					url : "${home}getBurndownChartData.html",
					data : request,
					//data : JSON.stringify(search),
					//dataType : 'json',
					timeout : 100000,
					success : function(data) {
						console.log("SUCCESS: ", data);
						DrawChart(
								myselect.options[myselect.selectedIndex].value,
								data);
						//CreateSampleChart(myselect.options[myselect.selectedIndex].value);

					},
					error : function(e) {
						console.log("ERROR: ", e);
						alert("ERROR");
					},
					done : function(e) {
						console.log("DONE");
					}
				});

	}
</script>

<div class="form-group">
	<label for="sel1">Select Sprint:</label> <select class="form-control"
		id="selectOpt" onChange="OnChange();">
		<option>Select a Sprint</option>
		<c:forEach items="${sprints}" var="sprint">
			<option>${sprint.name}</option>
		</c:forEach>
	</select>
</div>

<main>
<div class="container">
	<div id="chart" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
</div>
</main>
