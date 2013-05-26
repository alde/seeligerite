require 'testhelper'

module Seeligerite
  module Bit
    describe Twiddle do
      include Ramcrest::Is

      it "can set a bit on" do
        assert_that Twiddle.set_bit(10, 2, true), is(14)
        assert_that Twiddle.enable_bit(10, 2), is(14)
      end

      it "can set a bit off" do
        assert_that Twiddle.set_bit(5, 2, false), is(1)
        assert_that Twiddle.clear_bit(5, 2), is(1)
      end

      it "can toggle a bit" do
        assert_that Twiddle.toggle_bit(5, 2), is(1)
        assert_that Twiddle.toggle_bit(1, 2), is(5)
      end

      it "can test a bit" do
        assert_that Twiddle.test_bit(5, 2), is(true)
        assert_that Twiddle.test_bit(15, 4), is(false)
      end

      it "can set several bits" do
        assert_that Twiddle.set_bits(16, 4, true), is(20)
        assert_that Twiddle.enable_bits(16, 4), is(20)
      end

      it "can clear several bits" do
        assert_that Twiddle.set_bits(20, 4, false), is(16)
        assert_that Twiddle.clear_bits(20, 4), is(16)
      end

      it "can toggle several bits" do
        assert_that Twiddle.toggle_bits(20, 4), is(16)
        assert_that Twiddle.toggle_bits(123, 4), is(127)
      end

      it "can test so all bits are set" do
        assert_that Twiddle.test_all_bits(16, 3), is(false)
      end

      it "can test so any bits are set" do
        assert_that Twiddle.test_any_bits(16, 3), is(false)
      end

      it "can set and get a value" do
        val = Twiddle.set_value(16, 2, 5, 4)
        assert_that val, is(16)
        assert_that Twiddle.get_value(val, 2, 5), is(4)
      end

      it "can get a mask" do
        assert_that Twiddle.get_mask(3,7), is(248)
      end
    end
  end
end
