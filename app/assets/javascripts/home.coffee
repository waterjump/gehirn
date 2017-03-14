$ ->
  language = 'Deutsch'
  timer = undefined

  setLanguage = ->
    language = $('#language').val()
    return

  fillAudio = (json) ->
    if json.sound.length > 0
      $('#sound').html '<a href="' + json.sound + '">' + json.q + '</a>'
    else
      $('#sound').html '<p>No audio found.</p>'
    return

  fillError = (json) ->
    $('#error').html '<p>' + json.error + '</p>'
    return

  $('#q').focus()
  $('#language').on 'change', ->
    setLanguage()
    return
  $('#q').on 'keyup', ->
    $('#pronunciation-holder').fadeOut()
    clearTimeout timer
    q = $(this).val()
    return if q.trim().length == 0
    timer = setTimeout((->
      $.ajax(url: '/query?q=' + q.trim()).done (json) ->
        if json.error != undefined
          fillError json
          $('#ipa').html ''
          $('#sound').html ''
        else
          $('#error').html ''
          $('#ipa').html json.ipa
          fillAudio json
        $('#pronunciation-holder').fadeIn()
        return
      return
    ), 1000)
    return
  return
