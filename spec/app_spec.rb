require './app.rb'

describe App do
  let(:app) { App.new }

  context "GET homepage" do
    let(:response) { get "/" }

    it "return status 200" do
      expect(response.status).to eq 200
    end
  end
end