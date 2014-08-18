require_relative 'dir_indexer'

class DesktopDirIndexer < DirIndexer

   def accept_item(path)
      is_dir? path or is_desktop_file? path
   end

   def index_file(path)
      file_node = create_file_node path
      file_node.set_attr :url, extract_desktop_url(path)

      file_node
   end

   def is_desktop_file?(path)
      path.end_with? '.desktop'
   end

   def extract_desktop_url(path)
      File.open(path, 'r') do |file|
         while line = file.gets
            return line if line.start_with? 'URL='
         end
      end

      nil
   end

end