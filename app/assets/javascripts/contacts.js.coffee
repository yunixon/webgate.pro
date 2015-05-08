# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#new_contact")
    .on "ajax:success", (event, data, status, xhr) ->
      $("#overlay").show()
      $("#form_msg").show()
      $("#new_contact")[0].reset()
    .on "ajax:error", (event, data, status, xhr) ->
      $.each($.parseJSON(data.responseText), (field, messages) ->
        input = $("#new_contact").find(':input').filter( ->
          name = $(this).attr('name')
          if name
            name.match(new RegExp('contact' + '\\[' + field + '\\(?'))
        )
        input.tooltipster
          theme: 'tooltipster-msg'
          maxWidth: 220
          position: 'left'
          onlyOne: true
        input.tooltipster('content', $('<div>' + $.map(messages, (m) -> m.charAt(0).toUpperCase() + m.slice(1)).join('<br />') + '</span>'))
        input.tooltipster('show')
      )
