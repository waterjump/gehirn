class SearchTerm
  def initialize(language, q)
    @q = q
    @language = language
  end

  def results
    if wiktionary.present?
      {
        q: @q,
        ipa: ipa,
        sound: sound,
        images: images
      }
    else
      { error: 'No results.' }
    end
  end

  private

  def ipa
    wiktionary.ipa
  end

  def sound
    wiktionary.sound || forvo.sound
  end

  def images
    google.images
  end

  def wiktionary
    @wiktionary ||=
      begin
        wiki = Parsers::Wiktionary.new(@language, @q)
        return wiki if wiki.entry_found
        if german_lowercase?
          @q = @q.titleize
          return Parsers::Wiktionary.new(@language, @q)
        end
        nil
      end
  end

  def forvo
    @forvo ||= Parsers::Forvo.new(@language, @q)
  end

  def google
    @google ||= Parsers::Google.new(@language, @q)
  end

  def german_lowercase?
    @language == 'de' && @q[0].upcase != @q[0]
  end
end
