class Post < BaseModel
  attr_accessor :id, :title, :link, :author

  def initialize(opts = {})
    @id     = opts[:id]
    @title  = opts[:title]
    @link   = opts[:link]
    @author = opts[:author]
  end
end