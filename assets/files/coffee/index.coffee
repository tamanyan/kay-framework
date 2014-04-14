$ ->
  $serviceSwitch = $("[name='service-enable-checkbox']")
  $serviceSwitch.bootstrapSwitch
    size: "large"
    onColor: "success"
    onSwitchChange: (event, state) ->
      console.log event, state
      $serviceSwitch.bootstrapSwitch('toggleDisabled')
