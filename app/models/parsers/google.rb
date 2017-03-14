module Parsers
  class Google
    def initialize(q)
      @q = q
      @results =
        GoogleCustomSearchApi.search(
          @q,
          'searchType' => 'image',
          'hl' => 'de'
        )
    end

    def images
      @results.items.map do |i|
        next unless i['image'].present?
        next unless i['image']['thumbnailLink'].present?
        {
          file: i['image']['thumbnailLink'],
          snippet: i['htmlSnippet']
        }
      end
    end
  end
end
