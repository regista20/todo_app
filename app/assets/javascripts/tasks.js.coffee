# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateCountdown = ->
  remaining = 140 - jQuery("#task_content").val().length
  jQuery(".countdown").text remaining + " characters remaining"

jQuery ->
  updateCountdown()
  $("#task_content").change updateCountdown
  $("#task_content").keyup updateCountdown