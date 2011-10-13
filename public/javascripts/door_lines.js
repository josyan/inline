// this ugly hack because something somewhere conflict with the $ object from jQuery
var $j = jQuery;
$j(document).ready(function(){
  $j('.door-frame-list .door-frame').click(function(){
    $j('#door_line_door_frame_id').val($j(this).find('#df_id').val());
    $j('.door-frame-list form').submit();
  });
  $j('.door-combination-list .door-combination').click(function(){
    $j('#door_line_door_combination_id').val($j(this).find('#dc_id').val());
    $j('.door-combination-list form').submit();
  });
  $j('.frame-profile-list .frame-profile').click(function(){
    $j('#door_line_frame_profile_id').val($j(this).find('#fp_id').val());
    $j('.frame-profile-list form').submit();
  });
});
