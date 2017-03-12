$(function() {
  var language = 'Deutsch',
      timer;

  var setLanguage = function() {
    language = $('#language').val();
  };

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
        $('#ipa').html('/' + json.ipa + '/');
        $('#sound').html('<a href="' + json.sound + '">' + q + '</a>');
      });
    }, 1000);
  });
});
