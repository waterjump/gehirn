$ ->
  language = 'Deutsch'
  timer = undefined
  value = ''

  setLanguage = ->
    language = $('#language').val()
    return

  fillAudio = (json) ->
    if json.sound != null && (typeof json.sound == 'string' && json.sound.length > 0)
      $('#sound').html '<a href="' + json.sound + '" target="_blank">' + json.q + '</a>'
    else
      $('#sound').html '<p>No audio found.</p>'
    return

  fillError = (json) ->
    $('#error').html '<p>' + json.error + '</p>'
    return

  fillImages = (json) ->
    $(json.images).each ->
      $('.images').append '<div class="image"><img src="' + this.file + '" /><span class="snippet">' + this.snippet + '</span></div>'
    return

  clearForm = ->
    $('#contents').fadeOut 400, ->
      $('.images').html ''
      $('#ipa').html ''
      $('#sound').html ''
      $('#error').html ''
      return
    return

  $('#q').focus()
  clearForm()
  $('#language').on 'change', ->
    setLanguage()
    return
  $('#q').on 'keyup', ->
    q = $(this).val()
    return if q.trim().length == 0 || q.trim() == value
    clearForm()
    value = q
    clearTimeout timer
    timer = setTimeout((->
      $.ajax(url: '/query?q=' + q.trim()).done (json) ->
        if json.error != undefined
          fillError json
        else
          fillImages json
          $('#ipa').html json.ipa
          fillAudio json
        $('#contents').fadeIn()
        return
      return
    ), 1000)
    return
  return
