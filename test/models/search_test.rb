require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @search = Search.new
  end
  
  test "time and destination are nil" do
    @search.time = ""
    @search.destination = ""
    assert @search.valid?
  end
  
  test "time is nil but destination not nil" do
    @search.time = ""
    @search.destination = "中国科学院"
    assert @search.valid?
  end
  
  test "time is not nil but destination nil" do
    @search.time = "2019-01-20 00:30:00"
    @search.destination = ""
    assert @search.valid?
  end
    
end
