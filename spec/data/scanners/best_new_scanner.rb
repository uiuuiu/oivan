require './app.rb'
describe Data::Scanners::BestNewsScanner do
  let(:valid_data) { {result: "result testing", doc: "doc testing"} }
  
  context "Init scanner" do
    it "Init an scanner object without data" do
      obj = Data::Scanners::BestNewsScanner.new

      expect(obj).to have_attributes(result: nil, doc: nil)
    end

    it "cannot init new scanner with arguments" do
      expect {Data::Scanners::BestNewsScanner.new(valid_data)}.to raise_error(
        ArgumentError,
        "wrong number of arguments (given 1, expected 0)"
      )
    end
  end

  context "scanner methods" do
    context "scan/1" do
      it "scan with one argument" do
        obj = Data::Scanners::BestNewsScanner.new
        
        expect(obj.scan(1)).to be_truthy
        expect { obj.scan }.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 1)')
        expect { obj.scan(1,2) }.to raise_error(ArgumentError, 'wrong number of arguments (given 2, expected 1)')
      end

      it "scan then return list of Post" do
        obj = Data::Scanners::BestNewsScanner.new
        result = obj.scan(1)
        expect(result).to be_a(Hash)
        expect(result.first[1]).to be_a(Post)
      end

      it "scan then assign data to result attribute" do
        obj = Data::Scanners::BestNewsScanner.new
        obj.scan(1)
        expect(obj.result).to be_a(Hash)
        expect(obj.result.first[1]).to be_a(Hash)
      end
    end

    context "scan_content/1" do
      let (:url) { "https://www.google.com" }

      it "scan content with one argument" do
        obj = Data::Scanners::BestNewsScanner.new
        
        expect(obj.scan_content(url)).to be_truthy
        expect { obj.scan }.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 1)')
        expect { obj.scan(url,url) }.to raise_error(ArgumentError, 'wrong number of arguments (given 2, expected 1)')
      end

      it "scan content then return text" do
        obj = Data::Scanners::BestNewsScanner.new
        result = obj.scan_content(url)

        expect(result).to be_a(String)
      end
    end
  end
end