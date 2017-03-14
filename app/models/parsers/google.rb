module Parsers
  class Google
    def initialize(q)
      @q = q
      @results =
        GoogleCustomSearchApi.search(
          @q,
          'searchType' => 'image'
        )
    end

    def images
      Rails.logger.info "69BOT - image results: #{@results}"
      @results.items.map do |i|
        next unless i['image'].present?
        next unless i['image']['thumbnailLink'].present?
        i['image']['thumbnailLink']
        end.compact.uniq
    end
  end
end
