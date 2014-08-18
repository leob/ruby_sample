class Node
   attr_reader :children
   attr_reader :attrs

   def initialize(children = [])
      @children = children
      @attrs = {}
   end

   def add_child(child)
      @children << child
   end

   def is_leaf?
      @children.length == 0
   end

   def set_attr(name, value)
      @attrs[name] = value
   end

   def get_attr(name)
      @attrs[name]
   end

   def name=(name)
      @attrs[:name] = name
   end

   def name
      @attrs[:name]
   end

   def type=(type)
      @attrs[:type] = type
   end

   def type
      @attrs[:type]
   end
end