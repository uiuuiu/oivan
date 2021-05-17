module Storage
  def self.storage_path model
    if ENV["RACK_ENV"] == "test"
      return [App.root, "/storage/test/", model.name.downcase.pluralize, ".yml"].join
    end

    [App.root, "/storage/", model.name.downcase.pluralize, ".yml"].join
  end
end