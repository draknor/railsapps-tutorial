# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#// For fixed width containers
jQuery ->
  $('.datatable').dataTable({
    "sDom": "<'row'<'span4'l><'span5'f>r>t<'row'<'span4'i><'span5'p>>",
    "sPaginationType": "bootstrap"
    });
