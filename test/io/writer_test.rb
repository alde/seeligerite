require 'testhelper'

module Seeligerite
  module Io
    require 'archive'
    require 'fileutils'

    describe Writer do
      include Ramcrest::Comparable
      include Ramcrest::Aint

      file = File.expand_path(File.dirname(__FILE__) + '/testfile.txt')
      zipfile = File.expand_path(
        File.dirname(__FILE__) + '/data/testfile.zip'
      )
      old_directory = Dir.getwd

      before do
        Dir.chdir File.dirname(__FILE__)
        archive = Archive.new zipfile
        archive.extract
      end

      after do
        Dir.chdir old_directory
        FileUtils.rm_rf file
      end


      it "can be created" do
        Writer.new file
      end

      it "can write to string" do
        w = Writer.new file
        size_before = w.size

        w.write_string_8 "hojoj"
        w.flush
        size_after = w.size

        w.close

        assert_that(size_before, less_than(size_after))
      end

      it "can truncate a string" do
        w = Writer.new file
        size_before = w.size

        w.size = 5
        w.flush

        size_after = w.size

        w.close

        assert_that size_before, greater_than(size_after)
      end

      it "can change the offset" do
        w = Writer.new file
        pos_before = w.offset
        w.offset = 12
        pos_after = w.offset

        assert_that pos_after, aint(pos_before)
      end
    end
  end
end
