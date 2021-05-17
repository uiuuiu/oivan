class Data::Write
  attr_accessor :result

  # Save model data from raw data to storage
  # Description:
  # model: Post
  # data: { "1" => {id: 1, title: "New Post", author: "Dy", link: "http://localhost:3000"} }
  def write model, data
    collections = model.to_collections(data)
    @result = model.save(collections)
  end
end