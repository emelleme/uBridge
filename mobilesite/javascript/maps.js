<<<<<<< HEAD
$('#gmap').live("pageshow", function() {

=======
$('#gmap, #stations').live("pageshow", function() {
	$('.map_canvas').gmap({'center': '59.3426606750, 18.0736160278' }).bind('init', function(evt, map) {
		$('.map_canvas').gmap('addMarker', {'position': map.getCenter(), 'animation': google.maps.Animation.DROP }).click(function() { 
			$('.map_canvas').gmap('openInfoWindow', { 'content': 'Hello world!'}, this);
		});
	});
>>>>>>> 1af4fde37ba050a3978bea267a5c2dc1c72a3073
});
