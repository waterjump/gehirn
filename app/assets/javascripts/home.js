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

  $('#q').focus();

  $('#language').on('change', function(){
    setLanguage();
  });

  $('#q').on('keyup', function(){
    clearTimeout(timer);
    var q = $(this).val();
    timer = setTimeout(function(){
      $.ajax({
          url: "/query?q=" + q,
      }).done(function(json) {
        $('#ipa').html(json.ipa);
        fillAudio(json);
      })
    }, 1000);
  });
});
