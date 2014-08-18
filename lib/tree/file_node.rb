require_relative 'node'

class FileNode < Node

   def initialize(file)
      super()

      self.name = file
      self.type = :file
   end

end