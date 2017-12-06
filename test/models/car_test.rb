require 'test_helper'

class CarTest < ActiveSupport::TestCase
  test "should not save car without license/model/manufacturer/style/location/rate" do
    car = Car.new
    assert_not car.save
  end
end