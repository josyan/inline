// this ugly hack because something somewhere conflict with the $ object from jQuery
var $j = jQuery;
$j(document).ready(function(){

  var attach_door_panels_configuration_events = function(){
    // selected door panel interraction
    $j('#door-panels-configuration .selected-door-panel').click(function(e){
      e.stopPropagation();

      $j(this).parent().find('.door-panels-list').show();
    });

    // door panel interraction
    $j('#door-panels-configuration .door-panel').click(function(){
      id = $j(this).attr('id').replace('dp-', '');

      // highlight the selection
      $j(this).parent().find('.door-panel').removeClass('selected');
      $j(this).addClass('selected');

      // save the selection
      $j(this).closest('.door-line-section').find('#door-panel-id').val(id);

      // replace the selected panel preview with the new selected one
      $j(this).closest('.selection-door-panel').find('.selected-door-panel').html($j(this).html());

      // load the interface to configure glass families
      $j.get('/doors/configure_glass_families', {door_panel_id: id}, function(response) {
        $j(this).closest('.door-line-section').find('.selection-door-glass-family').html(response);
        attach_door_glass_families_configuration_events();
        $j(this).closest('.door-line-section').find('.selected-door-glass-family').change();
      });
    });
  };

  var attach_door_glass_families_configuration_events = function(){
    // TODO
  };

  // door frame interraction
  $j('#door-frame-selection .door-frame').click(function(){
    id = $j(this).attr('id').replace('df-', '');

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
  });

  // door combination interraction
  $j('#door-combination-selection .door-combination').click(function(){
    id = $j(this).attr('id').replace('dc-', '');

    // highlight the selection
    $j('#door-combination-selection .door-combination').removeClass('selected');
    $j(this).addClass('selected');

    // save the selection
    $j('#door_line_door_combination_id').val(id);

    // load the interface to configure panels
    $j.get('/doors/configure_panels', $j('#door-panels-configuration input').serialize() + '&door_combination_id=' + id, function(response) {
      $j('#door-panels-configuration').html(response);
      attach_door_panels_configuration_events();
      $j('#door-panels-configuration .door-panel.selected').click();
    });
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

  // ensure click anywhere hide popups
  $j('body').click(function(){
    $j('.door-popup').hide();
  });

  // launch click on first door frame to trigger events cascade
  $j('#door-frame-selection .door-frame.selected').click();
});
