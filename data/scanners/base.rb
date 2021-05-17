module Data::Scanners
  class Base
    attr_accessor :result, :doc
    
    def scan page
      raise "Not implement yet!"
    end

    def scan_content url
      raise "Not implement yet!"
    end
  end
end