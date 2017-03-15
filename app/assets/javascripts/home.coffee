$ ->
  language = 'de'
  timer = undefined
  value = ''

  setLanguage = ->
    language = $('#language option:selected').val()
    return

  fillAudio = (json) ->
    if json.sound != null && (typeof json.sound == 'string' && json.sound.length > 0)
      $('#sound').html '<span class="speaker">&#128266;</span><a href="' + json.sound + '" target="_blank">' + json.q + '</a>'
    else
      $('#sound').html '<p>No audio found.</p>'
    return

  fillError = (json) ->
    $('#error').html '<span class="centered h3">' + json.error + '</span>'
    return

  fillImages = (json) ->
    $(json.images).each ->
      $('#contents').append '<div class="image"><img src="' + this.file + '" /><span class="snippet">' + this.snippet + '</span></div>'
    return

  clearForm = ->
    $('#contents').fadeOut 400, ->
      $('.image').remove()
      els = ['#ipa','#sound','#error','#gender','#term']
      $.each els, (index, el) ->
        $(el).html ''
        return
      $('#loading').fadeIn()
      return
    return

  $('#q').focus()
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
      $.ajax(url: '/query?q=' + q.trim() + '&language=' + language).done (json) ->
        $('#loading').fadeOut()
        if json.error != undefined
          fillError json
        else
          fillImages json
          $('#ipa').html json.ipa
          $('#gender').html '(' + json.gender + ')' if json.gender.length > 0
          $('#term').html json.q
          fillAudio json
        $('#contents').fadeIn()
        return
      return
    ), 1000)
    return
  $(document).on('click tap', '.speaker', (e) ->
    e.preventDefault()
    url = $('#sound a').prop('href')
    audio = new Audio(url)
    audio.play()
    return
  )
  return
