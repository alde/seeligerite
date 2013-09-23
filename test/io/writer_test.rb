require 'testhelper'

module Seeligerite
  module Io
    require 'archive'
    require 'fileutils'

    describe Writer do
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
        @writer = Writer.new file
      end

      after do
        Dir.chdir old_directory
        FileUtils.rm_rf file
      end


      it "can be created" do
        Writer.new file
      end

      it "can write to string" do
        size_before = @writer.size

        @writer.write_string_8 "hojoj"
        @writer.flush
        size_after = @writer.size

        @writer.close

        assert_that(size_before, less_than(size_after))
      end

      it "can truncate a string" do
        size_before = @writer.size

        @writer.size = 5
        @writer.flush

        size_after = @writer.size

        @writer.close

        assert_that size_before, greater_than(size_after)
      end

      it "can change the offset" do
        pos_before = @writer.offset
        @writer.offset = 12
        pos_after = @writer.offset

        assert_that pos_after, aint(pos_before)
      end

      it "can write an int" do
        size_before = @writer.size
        @writer.write_int_8 93
        @writer.flush
        @writer.file.rewind
        content = @writer.file.read
        size_after = @writer.size
        @writer.close

        assert_that size_before, less_than(size_after)
        assert_that content.split.last, is("]")
      end
    end
  end
end
