require_relative 'tree/dir_node'
require_relative 'tree/file_node'

class DirIndexer

   def self.index(dir, include_empty_dirs)
      return new(include_empty_dirs).index_dir dir
   end

   def initialize(include_empty_dirs)
      @include_empty_dirs = include_empty_dirs
   end

   def index_dir(dir)
      nodes = []

      open_dir(dir)
            .reject { |name| name == '.' or name == '..' }  # skip the . and .. dirs, or we will get endless recursion!
            .map { |item| full_path(dir, item) } # get full file/directory path
            .select { |path| accept_item(path) }
            .each do |path|

         if is_dir? path
            node = index_dir path      # call index_dir recursively for subdirectories
         else
            node = index_file path
         end

         nodes << node if node
      end

      create_dir_node dir, nodes
   end

   def index_file(path)
      create_file_node path
   end

   def accept_item(path)
      true
   end

   def full_path(parent, child)
      File.join parent, child
   end

   def open_dir(dir)
      Dir.open dir
   end

   def is_dir?(path)
      File.directory? path
   end

   def create_dir_node(dir, nodes)
      if nodes.empty? and not @include_empty_dirs
         return nil
      end

      DirNode.new dir, nodes
   end

   def create_file_node(file)
      FileNode.new file
   end

end