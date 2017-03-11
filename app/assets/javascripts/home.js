$(function() {
  var language = 'Deutsch';

  var setLanguage = function() {
    language = $('#language').val();
  };

  var googleImageUrl = function(q) {
    switch (language) {
      case 'Deutsch':
        return 'https://www.google.de/search?hl=de&site=imghp&tbm=isch&source=hp&q=' + q
    }
  };  

  var wiktionaryUrl = function(q) {
    switch (language) {
      case 'Deutsch':
        return 'https://de.m.wiktionary.org/wiki/' + q
    }
  };

  var forvoUrl = function(q) {
    switch (language) {
      case 'Deutsch':
        return 'https://forvo.com/word/' + q + '/#de' 
    }
  };

  $('#language').on('change', function(){
    setLanguage();
  });

  $('#q').on('keyup', function(){
    var q = $(this).val();
    // $('iframe.google').prop('src', googleImageUrl(q));
    // $('iframe.wiktionary').prop('src', wiktionaryUrl(q));
    // $('iframe.forvo').prop('src', forvoUrl(q));
    
    $.ajax({
        url: "/query?q=" + q,
    }).done(function(json) {
      console.log(json);  
      // return $("#results").append(html);
    });

    $(this).focus();
  });
});
