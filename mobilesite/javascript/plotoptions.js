/* Lines */
	
	$(function () {
    var sin = [], cos = [];
    for (var i = 0; i < 10; i += 0.5) {
        sin.push([i, Math.sin(i)]);
        cos.push([i, Math.cos(i)]);
    }

    var plot = $.plot($(".chart"),
           [ { data: sin, label: "sin(x)"}, { data: cos, label: "cos(x)" } ], {
               series: {
                   lines: { show: true },
                   points: { show: true }
               },
               grid: { hoverable: true, clickable: true },
               yaxis: { min: -1.1, max: 1.1 },
			   xaxis: { min: 0, max: 9 }
             });

    function showTooltip(x, y, contents) {
        $('<div id="tooltip">' + contents + '</div>').css( {
            position: 'absolute',
            display: 'none',
            top: y + 5,
            left: x + 5,
            border: '1px solid #000',
            padding: '2px',
			'z-index': '9999',
            'background-color': '#202020',
			'color': '#fff',
			'font-size': '11px',
            opacity: 0.8
        }).appendTo("body").fadeIn(200);
    }

    var previousPoint = null;
    $(".chart").bind("plothover", function (event, pos, item) {
        $("#x").text(pos.x.toFixed(2));
        $("#y").text(pos.y.toFixed(2));

        if ($("#enableTooltip:checked").length > 0) {
            if (item) {
                if (previousPoint != item.dataIndex) {
                    previousPoint = item.dataIndex;
                    
                    $("#tooltip").remove();
                    var x = item.datapoint[0].toFixed(2),
                        y = item.datapoint[1].toFixed(2);
                    
                    showTooltip(item.pageX, item.pageY,
                                item.series.label + " of " + x + " = " + y);
                }
            }
            else {
                $("#tooltip").remove();
                previousPoint = null;            
            }
        }
    });

    $(".chart").bind("plotclick", function (event, pos, item) {
        if (item) {
            $("#clickdata").text("You clicked point " + item.dataIndex + " in " + item.series.label + ".");
            plot.highlight(item.series, item.datapoint);
        }
    });
});



	/* Lines with autodrowing */

	$(function () {
		// we use an inline data source in the example, usually data would
		// be fetched from a server
		var data = [], totalPoints = 200;
		function getRandomData() {
			if (data.length > 0)
				data = data.slice(1);
	
			// do a random walk
			while (data.length < totalPoints) {
				var prev = data.length > 0 ? data[data.length - 1] : 50;
				var y = prev + Math.random() * 10 - 5;
				if (y < 0)
					y = 0;
				if (y > 100)
					y = 100;
				data.push(y);
			}
	
			// zip the generated y values with the x values
			var res = [];
			for (var i = 0; i < data.length; ++i)
				res.push([i, data[i]])
			return res;
		}
	
		// setup control widget
		var updateInterval = 1000;
		$("#updateInterval").val(updateInterval).change(function () {
			var v = $(this).val();
			if (v && !isNaN(+v)) {
				updateInterval = +v;
				if (updateInterval < 1)
					updateInterval = 1;
				if (updateInterval > 2000)
					updateInterval = 2000;
				$(this).val("" + updateInterval);
			}
		});
	
		// setup plot
		var options = {
			yaxis: { min: 0, max: 100 },
			xaxis: { min: 0, max: 100 },
			colors: ["#afd8f8"],
			series: {
					   lines: { 
							lineWidth: 2, 
							fill: true,
							fillColor: { colors: [ { opacity: 0.1 }, { opacity: 0.2 } ] },
							//"#dcecf9"
							steps: false
	
						}
				   }
		};
		var plot = $.plot($(".autoUpdate"), [ getRandomData() ], options);
	
		function update() {
			plot.setData([ getRandomData() ]);
			// since the axes don't change, we don't need to call plot.setupGrid()
			plot.draw();
			
			setTimeout(update, updateInterval);
		}
	
		update();
	});



	/* Bars */

	$(function () {
    var d2 = [[0.6, 29], [2.6, 13], [4.6, 46], [6.6, 30], [8.6, 48], [10.6, 22], [12.6, 40], [14.6, 32], [16.6, 39], [18.6, 16], [20.6, 27], [22.6, 22], [24.6, 2], [26.6, 45], [28.6, 23], [30.6, 28], [32.6, 30], [34.6, 40], [36.6, 20], [38.6, 47], [40.6, 12], [42.6, 49], [44.6, 28], [46.6, 15], [48.6, 24]];
	
    var plot = $.plot($(".bars"),
           [ { data: d2} ], {
               series: {
                   bars: { 
					show: true,
					lineWidth: 0.5,
					barWidth: 0.85, 
					fill: true,
					fillColor: { colors: [ { opacity: 0.8 }, { opacity: 1 } ] },
					align: "left", 
					horizontal: false,
				   },
               },
               grid: { hoverable: true, clickable: true },
               yaxis: { min: 0, max: 50 },
			   xaxis: { min: 0, max: 50 },
             });

	});






	/* Pie charts */
	
	$(function () {
		var data = [];
		var series = Math.floor(Math.random()*10)+1;
		for( var i = 0; i<series; i++)
		{
			data[i] = { label: "Series"+(i+1), data: Math.floor(Math.random()*100)+1 }
		}
	
	$.plot($("#graph1"), data, 
	{
			series: {
				pie: { 
					show: true,
					radius: 1,
					label: {
						show: true,
						radius: 2/3,
						formatter: function(label, series){
							return '<div style="font-size:11px;text-align:center;padding:2px;color:white;">'+label+'<br/>'+Math.round(series.percent)+'%</div>';
						},
						threshold: 0.1
					}
				}
			},
			legend: {
				show: false
			},
			grid: {
				hoverable: false,
				clickable: true
			},
	});
	$("#interactive").bind("plothover", pieHover);
	$("#interactive").bind("plotclick", pieClick);
	
	$.plot($("#graph2"), data, 
	{
			series: {
				pie: { 
					show: true,
					radius:300,
					label: {
						show: true,
						formatter: function(label, series){
							return '<div style="font-size:11px;text-align:center;padding:2px;color:white;">'+label+'<br/>'+Math.round(series.percent)+'%</div>';
						},
						threshold: 0.1
					}
				}
			},
			legend: {
				show: false
			},
			grid: {
				hoverable: false,
				clickable: true
			}
	});
	$("#interactive").bind("plothover", pieHover);
	$("#interactive").bind("plotclick", pieClick);
	});
	
	function pieHover(event, pos, obj) 
	{
		if (!obj)
					return;
		percent = parseFloat(obj.series.percent).toFixed(2);
		$("#hover").html('<span style="font-weight: bold; color: '+obj.series.color+'">'+obj.series.label+' ('+percent+'%)</span>');
	}
	function pieClick(event, pos, obj) 
	{
		if (!obj)
					return;
		percent = parseFloat(obj.series.percent).toFixed(2);
		alert(''+obj.series.label+': '+percent+'%');
	}

