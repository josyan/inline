// this ugly hack because something somewhere conflict with the $ object from jQuery
var $j = jQuery;
$j(document).ready(function(){
  $j('.door-frame-list .door-frame').click(function(){
    $j('#door_line_door_frame_id').val($j(this).find('#df_id').val());
    $j('.door-frame-list form').submit();
  });
});
