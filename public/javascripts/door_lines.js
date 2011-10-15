// this ugly hack because something somewhere conflict with the $ object from jQuery
var $j = jQuery;
$j(document).ready(function(){

  // door frame interraction
  $j('#door-frame-selection .door-frame').click(function(){
    id = $j(this).attr('id').replace('df-', '');

    $j('#door_line_door_frame_id').val(id);
    $j('#door-combination-selection .door-combination-list').hide();
    $j('#door-combination-selection #dcl-' + id).show();
  });
});
