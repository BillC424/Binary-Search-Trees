class Node
  include Comparable

  attr_reader :data

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end

  def <=>(other_node)
    data <=> other_node.data
  end
end
# class Tree
#
#   #maybe this attribute needs to be a method instead?
#   attr_accessor :root
#
#   def initialize(array)
#     @array = array
#   end
#
#   def build_tree(array)
#     #base case
#     if array.kind_of?(array) == false
#       return
#     else
#       #base case for comparing node values
#
#       #find middle of array
#       middle = array / 2
#     #recursively calling method on left
#     #recursively calling method on left
#
#     # return level 0 root node
#   end
#
# end
five = Node.new(5)
three = Node.new(3)

p five.data > three.data

array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
