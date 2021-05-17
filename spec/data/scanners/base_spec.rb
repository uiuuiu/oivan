require './data/scanners/base.rb'

describe Data::Scanners::Base do
  let(:valid_data) { {result: "result testing", doc: "doc testing"} }
  
  it "Init an object with attributes: result, doc" do
    obj = Data::Scanners::Base.new

    expect(obj).to have_attributes(result: nil, doc: nil)
  end

  it "have abtract method scan" do
    obj = Data::Scanners::Base.new

    expect {obj.scan(1)}.to raise_error(RuntimeError, "Not implement yet!")
  end

  it "have abtract method scan_content" do
    obj = Data::Scanners::Base.new

    expect {obj.scan_content("https://google.com")}.to raise_error(RuntimeError, "Not implement yet!")
  end
end