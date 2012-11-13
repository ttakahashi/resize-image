require "k5"
require 'imlib2'
describe calcsize do
  it "test" do
  Imlib2::Image.new(400, 300)
    calcsize.new(400, 300, 400, 300)
    calcsize.dst[:w].should == 400
  end
end