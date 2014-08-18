require 'minitest/autorun'
require 'shoulda'

require_relative '../lib/desktop_dir_indexer'

class TestDirIndexer < MiniTest::Test

   context 'basic' do
      setup do
         @mock_dir_indexer = DesktopDirIndexer.new(false)

         class << @mock_dir_indexer
            def open_dir(dir)
               return %w(dummy1.desktop dummy2.desktop dummy3.skipthis subDir) if dir.end_with? 'rootDir'
               return %w(dummy.desktop nestedDir) if dir.end_with? 'subDir'
               return []
            end

            def is_dir?(dir)
               return dir.end_with? 'Dir'
            end

            def extract_desktop_url(path)
               return 'URL=dummy'
            end
         end
      end

      should 'return nil if the directory is unknown' do
         root = @mock_dir_indexer.index_dir('unknown')
         assert_nil root
      end

      should 'return 0 nodes and 1 item for directory subDir' do
         root = @mock_dir_indexer.index_dir('subDir')
         assert_equal 0, root.directories.count
         assert_equal 1, root.files.count
      end

      should 'return 1 node and 2 items for directory rootDir' do
         root = @mock_dir_indexer.index_dir('rootDir')
         assert_equal 1, root.directories.count
         assert_equal 2, root.files.count
      end
   end

end