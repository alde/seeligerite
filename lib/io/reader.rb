module Seeligerite
  module Io
    class Reader < RWBase

      public
        def available?
          offset < size
        end

        def skip len
          raise "Argument len must not be negative." if len < 0
          return nil if len == 0
          raise "Can't operate on a closed file." if @file.nil?
          @file.seek len
        end

        def read len
          raise "Argument len must not be negative." if len < 0
          return '' if len == 0
          raise "Can't operate on a closed file." if @file.nil?
          @file.read len
        end

        def read_int_8
          ord = read(1).ord
          return -ord - 2 * (128 - ord) if (ord > 127)
          ord
        end

        def read_uint_8
          read(1).ord
        end

        def read_int_16_le
          if big_endian? then
            from_int_16 read(2).reverse
          else
            from_int_16 read(2)
          end
        end

        def read_int_16_be
          if little_endian? then
            from_int_16 read(2).reverse
          else
            from_int_16 read(2)
          end
        end

      private
        def from_int_16 val
          value.unpack('s*').last
        end
    end
  end
end
