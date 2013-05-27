module Seeligerite
  module Io
    class Writer < RWBase

      private
        @endianess = 0

      public
        def write value, length = nil
          raise "Can't operate on a closed file." if @file.nil?
          length = value.length if length.nil?
          @file.write value
          @size += length
        end

        def write_int_8 value
          write [value].pack('c*')
        end

        def write_uint_16 value
          write [value].pack('C*')
        end

        def write_int_16_le value
          if little_endian? then
            write to_i16(value).reverse
          else
            write to_i16(value)
          end
        end

        ##
        # Returns signed 16-bit integer as big-endian ordered binary data to the
        # stream.
        #
        # = params
        # - integer $value The input value.
        def write_int_16_be value
          if big_endian? then
            write to_i16(value).reverse
          else
            write to_i16(value)
          end
        end

        def write_uint_16_le value
          write [value].pack('v*')
        end

        def write_uint_16_be value
          write [value].pack('n*')
        end

        def write_int_32_le value
          if little_endian? then
            write to_i32(value).reverse
          else
            write to_i32(value)
          end
        end

        def write_int_32_be value
          if big_endian? then
            write to_i32(value).reverse
          else
            write to_i32(value)
          end
        end

        def write_uint_32_le value
          write [value].pack('V*')
        end

        def write_uint_32_be value
          write [value].pack('N*')
        end

        def write_int_64_le value
          write [value].pack('q*')
        end

        def write_int_64_be value
          write [value].pack('Q*')
        end

        def write_float_le value
          if little_endian? then
            write to_f(value).reverse
          else
            write to_f(value)
          end
        end

        def write_float_be value
          if big_endian? then
            write to_f(value).reverse
          else
            write to_f(value)
          end
        end

        def write_string_8 value, length = nil, padding = "\0"
          length = value.length if length.nil?
          length += value.length if (length < value.length)

          write value.ljust(length, padding)
        end

        def write_string_16 value, order = nil, length = nil, padding = "\0"
          length = (value.length / 2) if length.nil?
          length += (value.length / 2) if length < (value.length / 2)
          if order == BIG_ENDIAN_ORDER and not (value[0].ord == 0xfe and value[1].ord == 0xff) then
            value = value.insert(0, 0xfeff)
            length += 1
          end

          if order == LITTLE_ENDIAN_ORDER and not (value[0].ord == 0xff and value[1].ord == 0xfe) then
            value = value.insert(0, 0xfffe)
            length += 1
          end

          write value.ljust(length * 2, padding)
        end

        def write_hhex value
          write [value].pack('H*')
        end

        def write_lhex value
          write [value].pack('h*')
        end

        def write_guid value
          c = /-/.split value
          write(
            [
              c[0].hex,
              c[1].hex,
              c[2].hex,
              (c[3] + c[4][0..4]).hex,
              c[4][4..-1].hex
            ].pack('V1v2N2')
          )
        end

      private
        def to_i16 value
          [value].pack('s*')
        end

        def to_i32 value
          [value].pack('l*')
        end

        def to_f value
          [value].pack('f*')
        end

        def little_endian?
          endian == LITTLE_ENDIAN_ORDER
        end

        def big_endian?
          endian == BIG_ENDIAN_ORDER
        end

        def endian
          if @endianess == 0 then
            @endianess = if to_i32("\x01\x00\x00\x00") == 1 then
              LITTLE_ENDIAN_ORDER
            else
              BIG_ENDIAN_ORDER
            end
          end

          @endianess
        end
    end
  end
end
