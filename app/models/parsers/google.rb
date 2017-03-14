module Parsers
  class Google < Parser
    def images
      @response.items.map do |i|
        next unless i['image'].present?
        next unless i['image']['thumbnailLink'].present?
        {
          file: i['image']['thumbnailLink'],
          snippet: i['htmlSnippet']
        }
      end
    end

    private

    def fetch_response
      GoogleCustomSearchApi.search(
        @q,
        'searchType' => 'image',
        'hl' => @language
      )
    end
  end
end
