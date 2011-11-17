// this ugly hack because something somewhere conflict with the $ object from jQuery
var $j = jQuery;
$j(document).ready(function(){

  // door configuration interraction
  var attach_configuration_events = function(root_item){
    root_item.find('.single-section .selected-door-panel').click(function(e){
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

    // generate the interface to configure panels and glasses
    $j.get('/doors/configure', {door_combination_id: id}, function(response) {
      $j('#door_panels_configuration').html(response);
      attach_configuration_events($j('#door_panels_configuration'));
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

  // plug interraction on configuration part
  attach_configuration_events($j('#door_panels_configuration'));
});
