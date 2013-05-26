module Seeligerite
  module Bit

    ##
    # Class for twiddling bits
    class Twiddle
      private
        ##
        # Hide the constructor
        def initialize
        end

      public

        ##
        # Sets a bit at a given position in an integer.
        #
        # = params
        # - integer int  The value to manipulate.
        # - integer pos  The position of the bit to set.
        # - boolean on   Whether to enable or clear the bit.
        #
        # = return
        # - integer the twiddled integer
        def self.set_bit int, pos, on
          if on then
            self.enable_bit int, pos
          else
            self.clear_bit int, pos
          end
        end

        ##
        # Enables a bit at a given position in an integer.
        #
        # = params
        # - integer int  The value to manipulate.
        # - integer pos  The position of the bit to set.
        #
        # = return
        # - integer the twiddled integer
        def self.enable_bit int, pos
          int | (1 << pos)
        end

        ##
        # Clears a bit at a given position in an integer.
        #
        # = params
        # - integer int  The value to manipulate.
        # - integer pos  The position of the bit to set.
        #
        # = return
        # - integer the twiddled integer
        def self.clear_bit int, pos
          int & ~(1 << pos)
        end

        ##
        # Toggles a bit at a given position in an integer.
        #
        # = params
        # - integer int  The value to manipulate.
        # - integer pos  The position of the bit to set.
        #
        # = return
        # - integer the twiddled integer
        def self.toggle_bit int, pos
          int ^ (1 << pos)
        end

        ##
        # Tests a bit at a given position in an integer.
        #
        # = params
        # - integer int  The value to manipulate.
        # - integer pos  The position of the bit to test.
        #
        # = return
        # - integer the twiddled integer
        def self.test_bit int, pos
          (int & (1 << pos)) != 0
        end

        ##
        # Sets a given set of bits in an integer.
        #
        # = params
        # - integer int  The value to manipulate.
        # - integer bits The bits to set.
        # - boolean on   Wether to enable or disable the bits.
        #
        # = return
        # - integer the twiddled integer
        def self.set_bits int, bits, on
          if on then
            self.enable_bits int, bits
          else
            self.clear_bits int, bits
          end
        end

        ##
        # Enables a given set of bits in an integer.
        #
        # = params
        # - integer int  The value to manipulate.
        # - integer bits The bits to set.
        #
        # = return
        # - integer the twiddled integer
        def self.enable_bits int, bits
          int | bits
        end

        ##
        # Clears a given set of bits in an integer.
        #
        # = params
        # - integer int  The value to manipulate.
        # - integer bits The bits to set.
        #
        # = return
        # - integer the twiddled integer
        def self.clear_bits int, bits
          int & ~bits
        end

        ##
        # Toggles a given set of bits in an integer.
        #
        # = params
        # - integer int  The value to manipulate.
        # - integer bits The bits to set.
        #
        # = return
        # - integer the twiddled integer
        def self.toggle_bits int, bits
          int ^ bits
        end

        ##
        # Tests a given set of bits in an integer
        # to see if all are set.
        #
        # = params
        # - integer int  The value to manipulate.
        # - integer bits The bits to test.
        #
        # = return
        # - boolean true if all bits are set
        def self.test_all_bits int, bits
          (int & bits) == bits
        end

        ##
        # Tests a given set of bits in an integer
        # to see if any are set.
        #
        # = params
        # - integer int  The value to manipulate.
        # - integer bits The bits to test.
        #
        # = return
        # - boolean true if any bit is set
        def self.test_any_bits int, bits
          (int & bits) != 0
        end

        ##
        # Stores a value in a given range in an integer.
        #
        # = params
        # - integer integer The value to store into.
        # - integer start   The position to store from. Must be <= stop.
        # - integer stop    The position to store to. Must be >= start.
        # - integer value   The value to store.
        #
        # = return
        # - integer
        def self.set_value int, start, stop, value
          self.clear_bits(int, self.get_mask(start, stop) << start) | (value << start)
        end

        ##
        # Gets a value stored in a given range in an integer.
        #
        # = params
        # - integer integer The value to get from.
        # - integer start   The position to get from. Must be <= stop.
        # - integer stop    The position to get to. Must be >= start.
        #
        # = return
        # - integer
        def self.get_value int, start, stop
          (int & self.get_mask(start, stop)) >> start
        end

        ##
        #
        # Returns an integer with all bits set from start to end.
        #
        # = params
        # - integer start  The position to start setting bits from. Must
        #                       be <= stop.
        # - integer stop   The position to stop setting bits. Must
        #                       be >= start.
        #
        # = return
        # - integer
        def self.get_mask start, stop
          (tmp = (1 << stop)) + tmp - (1 << start)
        end
    end
  end
end
