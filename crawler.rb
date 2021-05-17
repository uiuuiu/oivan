class Crawler
  attr_reader :scanner, :writor

  def initialize(scanner:, writor:)
    @scanner = scanner
    @writor = writor
  end

  def fetch_page(page=1)
    scanner.scan(page)
    writor.write(Post, scanner.result)
  end
end