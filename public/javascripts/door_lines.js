// this ugly hack because something somewhere conflict with the $ object from jQuery
var $j = jQuery;
$j(document).ready(function(){

  // door configuration interraction
  var attach_door_panels_configuration_events_2 = function(){
    $j('#door-panels-configuration .single-section .selected-door-panel').click(function(e){
      e.stopPropagation();
      selected = $j(this);
      popup = $j(this).parent().find('.list-door-panels');

      // panel choices interraction
      popup.find('.door-panel').click(function(){
        value_holder = $j(this).closest('.single-section').find('#door_sections__door_panel');
        id = $j(this).attr('id').replace('dp-', '');

        if(id != value_holder.val()){

          // highlight the selection
          popup.find('.door-panel').removeClass('selected');
          $j(this).addClass('selected');

          // save the selection
          value_holder.val(id);

          // update section image
          selected.html($j(this).html());
        }
      });

      // ensure popup is shown and hidden correctly
      $j('body').click(function(){
        popup.hide();
      });
      popup.show();
    });
  };

  var attach_door_panels_configuration_events = function(){

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
    });
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
    $j.get('/doors/configure_panels', {door_combination_id: id}, function(response) {
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

  // launch click on first door frame to trigger events cascade
  $j('#door-frame-selection .door-frame.selected').click();
});
