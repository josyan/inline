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
      var selected_panel = $j(this);
      var section = selected_panel.closest('.door-line-section');
      var id = selected_panel.attr('id').replace('dp-', '');
      var door_glass_id = section.find('#door-glass-id').val();

      // highlight the selection
      selected_panel.parent().find('.door-panel').removeClass('selected');
      selected_panel.addClass('selected');

      // save the selection
      section.find('#door-panel-id').val(id);

      // replace the selected panel preview with the new selected one
      selected_panel.closest('.selection-door-panel').find('.selected-door-panel').html(selected_panel.html());

      // load the interface to configure glass families
      $j.get('/doors/configure_glass_families', {door_panel_id: id, door_glass_id: door_glass_id}, function(response) {
        section.find('.selection-door-glass-family').html(response);
        attach_door_glass_families_configuration_events(section);
        section.find('#door_glass_family').change();
      });
    });
  };

  var attach_door_glass_families_configuration_events = function(section){
    section.find('#door_glass_family').change(function(){
      var id = $j(this).val();

      if(id == '0') {
        section.find('#door-glass-id').val('');
        section.find('.selection-door-glass').html('');
      } else {
        // load the interface to configure glasses
        $j.get('/doors/configure_glasses', {door_glass_family_id: id}, function(response) {
          section.find('.selection-door-glass').html(response);
          attach_door_glasses_configuration_events(section);
          section.find('.door-glass.selected').click();
        });
      }
    });
  };

  var attach_door_glasses_configuration_events = function(section){
    // selected door glass interraction
    section.find('.selected-door-glass').click(function(e){
      e.stopPropagation();

      $j(this).parent().find('.door-glasses-list').show();
    });

    // door glass interraction
    section.find('.door-glass').click(function(){
      var selected_glass = $j(this);
      var id = selected_glass.attr('id').replace('dg-', '');

      // highlight the selection
      selected_glass.parent().find('.door-glass').removeClass('selected');
      selected_glass.addClass('selected');

      // save the selection
      section.find('#door-glass-id').val(id);

      // replace the selected glass preview with the new selected one
      section.find('.selected-door-glass').html(selected_glass.html());
    });
  };

  // door frame interraction
  $j('#door-frame-selection .door-frame').click(function(){
    var id = $j(this).attr('id').replace('df-', '');

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
    var id = $j(this).attr('id').replace('dc-', '');

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
    var id = $j(this).attr('id').replace('fp-', '');

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
