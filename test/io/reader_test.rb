require 'testhelper'

module Seeligerite
  module Io
    require 'archive'
    require 'fileutils'

    describe Reader do
      include Ramcrest::Comparable
      include Ramcrest::Aint
      include Ramcrest::Is

      file = File.expand_path(File.dirname(__FILE__) + '/testfile.txt')
      zipfile = File.expand_path(
        File.dirname(__FILE__) + '/data/testfile.zip'
      )
      old_directory = Dir.getwd

      before do
        Dir.chdir File.dirname(__FILE__)
        archive = Archive.new zipfile
        archive.extract
        @reader = Reader.new file
      end

      after do
        Dir.chdir old_directory
        FileUtils.rm_rf file
      end


      it "can be created" do
        Reader.new file
      end

      it "can skip ahead" do
        five_ahead = @reader.skip 5
        assert_that five_ahead, aint('')
        assert_that five_ahead, aint(nil)
      end

      it "can't skip back" do
        assert_raises RuntimeError do
          @reader.skip -5
        end
      end

      it "can read a file" do
        assert_that @reader.read(13), is("This file has")
      end

      it "can read a file into an 8 bit integer" do
        assert_that @reader.read_int_8, is(84)
      end

      it "can read a file into an unsigned 8 bit integer" do
        assert_that @reader.read_uint_8, is(84)
      end

      it "can read a file into an 16 bit lower endian integer" do
        assert_that @reader.read_int_16_le, is(26708)
      end

      it "can read a file into a 16 bit big endian integer" do
        assert_that @reader.read_int_16_be, is(21608)
      end
    end
  end
end
