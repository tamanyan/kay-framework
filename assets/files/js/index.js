$(function() {
  var $serviceSwitch;
  $serviceSwitch = $("[name='service-enable-checkbox']");
  return $serviceSwitch.bootstrapSwitch({
    size: "large",
    onColor: "success",
    onSwitchChange: function(event, state) {
      console.log(event, state);
      return console.log($serviceSwitch.bootstrapSwitch('toggleDisabled'));
    }
  });
});
