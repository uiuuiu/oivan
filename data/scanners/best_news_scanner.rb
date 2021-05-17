require 'open-uri'

module Data::Scanners
  class BestNewsScanner < Base
    BASE_SOURCE = 'https://news.ycombinator.com/best'

    def scan page
      @doc = Nokogiri::HTML(URI.open(scan_url(page)))
      table_data = @doc.css("table .itemlist")
      chunk_topics = table_data.css("tr.athing, tr:not([class])").each_slice(2).to_a
      chunk_topics.pop
      
      @result = collect_informations(chunk_topics)
      Post.bulk_insert(@result)
    end

    def scan_content url
      source = open(url).read
      Readability::Document.new(
        source,
        tags: %w[div p img a h1 h2 h3 span strong ul li pre code figure iframe],
        attributes: %w[src href],
        remove_empty_nodes: false
        ).content
    end

    private

    def scan_url page
      [BASE_SOURCE, "?p=", page].join()
    end

    def collect_informations topic_docs
      data = {}
      topic_docs.map do |docs|
        data[docs[0].attr("id")] = {
          id: docs[0].attr("id").to_i,
          link: docs[0].css("td.title a")[0].attr("href"),
          title: docs[0].css("td.title a")[0].content.strip,
          author: docs[1].css(".hnuser")[0].content
        }
      end
      data
    end
  end
end