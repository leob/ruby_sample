require_relative '../lib/desktop_dir_indexer'

def display(dir_tree)
   puts dir_tree.name

   dir_tree.files.each do |file|
      puts "#{file.name} - #{file.get_attr :url}"
   end

   dir_tree.directories.each do |dir|
      display(dir)
   end
end

dir = ARGV[0]

dir_tree = DesktopDirIndexer.index dir, false
display(dir_tree) if dir_tree
