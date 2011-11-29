$(document).ready(function () {

  //apply overrides here
  //$.mobile.defaultTransition = 'fade';
  // Date with external button
    $('#date1').scroller();
    // Time
    $('#date2').scroller({ preset: 'time' });
    // Datetime
    $('#date3').scroller();
    
	$('#date4').scroller({ preset: 'time' });

    $('#theme, #mode').change(function() {
        var t = $('#theme').val();
        var m = $('#mode').val();
        $('#date1').scroller('destroy').scroller({ theme: t, mode: m });
        $('#date2').scroller('destroy').scroller({ preset: 'time', theme: t, mode: m });
        $('#date3').scroller('destroy').scroller({ preset: 'datetime', theme: t, mode: m });
        $('#custom').scroller('option', { theme: t, mode: m });
    });

});
