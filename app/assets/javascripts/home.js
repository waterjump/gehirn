$(function() {
  var language = 'Deutsch',
      timer;

  var setLanguage = function() {
    language = $('#language').val();
  };

  var fillAudio = function(json) {
    if (json.sound.length > 0) {
      $('#sound').html(
        '<a href="' + json.sound + '">' + json.q + '</a>'
      );
    } else {
      $('#sound').html('<p>No audio found.</p>');
    }
  };

  var fillError = function(json) {
    $('#error').html('<p>' + json.error + '</p>');
  };

  $('#q').focus();

  $('#language').on('change', function(){
    setLanguage();
  });

  $('#q').on('keyup', function(){
    $('#pronunciation-holder').fadeOut();
    clearTimeout(timer);
    var q = $(this).val();
    timer = setTimeout(function(){
      $.ajax({
          url: "/query?q=" + q,
      }).done(function(json) {
        if (json.error !== undefined) {
          fillError(json);
        } else {
          $('#error').html('');
          $('#ipa').html(json.ipa);
          fillAudio(json);
        }
        $('#pronunciation-holder').fadeIn();
      })
    }, 1000);
  });
});
