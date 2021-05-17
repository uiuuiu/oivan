require 'yaml'

class BaseModel

  class << self
    def storage_path
      Storage.storage_path(self)
    end

    def all
      YAML.load(File.read(storage_path)) || {}
    end

    def to_collections collections
      collections.map do |id, data|
        obj = self.new(id: id)
        data.each do |key, value|
          obj[key] = value
        end
        obj
      end
    end

    def find_by_id id
      all[id] || all[id.to_s]
    end

    def bulk_insert collections
      new_collections = to_collections(collections)
      records = all
      new_collections.each do |collection|
        records[collection.id] = collection
      end
      save(records)
      new_collections
    end

    def save data
      File.open(storage_path, "w") { |file| file.write(data.to_yaml) }
      data
    end
  end

  def save
    records = self.class.all
    records[self.id] = self
    self.class.save(records)
  end

  def [] attr
    self.send(attr)
  end

  def []= attr, value
    self.send("#{attr}=", value)
  end
end