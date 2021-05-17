class Data::Fetcher

  def get_all page, scanner
    data = scanner.scan(page)
    data
  end
end