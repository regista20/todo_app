updateCountdown = ->
  remaining = 140 - jQuery('#task_content').val().length
  jQuery('.countdown').text remaining + " characters remaining"
  jQuery('.countdown').html '<span class="countdown alert alert-error">characters too many.</span>' if remaining < 0
  jQuery('.countdown').removeClass 'alert alert-error' if remaining > 0

jQuery ->
  updateCountdown()
  $('#new_task').append '<span class="countdown">140 characters remaining</span>'
  $('#task_content').change updateCountdown
  $('#task_content').keyup updateCountdown