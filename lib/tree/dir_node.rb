require_relative 'node'

class DirNode < Node

   def initialize(dir, children)
      super(children)

      self.name = dir
      self.type = :dir
   end

   def directories
      children.select {|child| child.type == :dir}
   end

   def files
      children.select {|child| child.type == :file}
   end

end