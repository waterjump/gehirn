class SearchTerm
  def initialize(q)
    @q = q
    @language = 'de'
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
        wiki = Parsers::Wiktionary.new(@q)
        return wiki if wiki.entry_found
        if german_lowercase?
          @q = @q.titleize
          return Parsers::Wiktionary.new(@q)
        end
        nil
      end
  end

  def forvo
    @forvo ||= Parsers::Forvo.new(@q)
  end

  def google
    @google ||= Parsers::Google.new(@q)
  end

  def german_lowercase?
    @language == 'de' && @q[0].upcase != @q[0]
  end
end
