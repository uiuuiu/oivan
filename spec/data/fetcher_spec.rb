require './app.rb'

describe Data::Fetcher do
  let(:scanner) { Data::Scanners::BestNewsScanner.new }

  context "Init fetcher" do
    it "Init a fetcher object" do
      obj = Data::Fetcher.new

      expect(obj).to be_a(Data::Fetcher)
    end
  end

  context "fetcher methods" do
    let(:obj) { Data::Fetcher.new }
    context "get_all/2" do
      it "scan with two arguments" do
        expect(obj.get_all(1, scanner)).to be_truthy
        expect { obj.get_all }.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 2)')
        expect { obj.get_all(1) }.to raise_error(ArgumentError, 'wrong number of arguments (given 1, expected 2)')
        expect { obj.get_all(1, 2, 3) }.to raise_error(ArgumentError, 'wrong number of arguments (given 3, expected 2)')
      end

      it "scan then return list of Post" do
        result = obj.get_all(1, scanner)
        expect(result).to be_a(Array)
        expect(result.first).to be_a(Post)
      end
    end
  end
end