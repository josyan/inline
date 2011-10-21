// this ugly hack because something somewhere conflict with the $ object from jQuery
var $j = jQuery;
$j(document).ready(function(){

  // door frame interraction
  $j('#door-frame-selection .door-frame').click(function(){
    id = $j(this).attr('id').replace('df-', '');

    if(id != $j('#door_line_door_frame_id').val()){

      // highlight the selection
      $j('#door-frame-selection .door-frame').removeClass('selected');
      $j(this).addClass('selected');

      // save the selection
      $j('#door_line_door_frame_id').val(id);

      // show the right door combinations list
      $j('#door-combination-selection .door-combination-list').hide();
      $j('#door-combination-selection #dcl-' + id).show();

      // launch click on first door combination
      $j('#door-combination-selection #dcl-' + id + ' .door-combination:first').click();
    }
  });

  // door combination interraction
  $j('#door-combination-selection .door-combination').click(function(){
    id = $j(this).attr('id').replace('dc-', '');

    // highlight the selection
    $j('#door-combination-selection .door-combination').removeClass('selected');
    $j(this).addClass('selected');

    // save the selection
    $j('#door_line_door_combination_id').val(id);
  });

  // frame profile interraction
  $j('#frame-profile-selection .frame-profile').click(function(){
    id = $j(this).attr('id').replace('fp-', '');

    // highlight the selection
    $j('#frame-profile-selection .frame-profile').removeClass('selected');
    $j(this).addClass('selected');

    // save the selection
    $j('#door_line_frame_profile_id').val(id);
  });

  // door panel interraction
  $j('#door-panel-selection .door-panel').click(function(){
    id = $j(this).attr('id').replace('dp-', '');

    // highlight the selection
    $j('#door-panel-selection .door-panel').removeClass('selected');
    $j(this).addClass('selected');

    // save the selection
    $j('#door_line_door_panel_id').val(id);
  });
});
