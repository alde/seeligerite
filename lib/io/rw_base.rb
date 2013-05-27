module Seeligerite
  module Io
    class RWBase
      MACHINE_ENDIAN_ORDER = 0;
      LITTLE_ENDIAN_ORDER = 1;
      BIG_ENDIAN_ORDER = 2;

      attr_accessor :file

      def initialize file
        name = self.class.to_s.split('::').last
        raise "Can't be instantiated." if name == 'RWBase'

        @file = File.open file, 'r+'
        @file.seek 0, IO::SEEK_END
        @size = @file.pos
        @file.seek offset
      end

      def offset
        raise "Can't operate on a closed file." if @file.nil?
        @file.pos
      end

      def offset= int
        raise "Can't operate on a closed file." if @file.nil?
        @file.seek int
      end

      def size= int
        raise "Can't operate on a closed file." if @file.nil?
        @file.truncate int
      end

      def size
        @file.size
      end

      def flush
        raise "Can't operate on a closed file." if @file.nil?
        @file.flush
      end

      def close
        @file.close
        @file = nil
      end
    end
  end
end
