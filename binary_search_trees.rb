class Node
  include Comparable

  attr_reader :data, :left_child, :right_child

  def initialize(data = nil, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end

  def <=>(other_node)
    data <=> other_node.data
  end
end

class Tree

  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    # base case
    if array.is_a?(Array) == false 
      nil
    elsif array.length <= 1
      return root
    else  
      # base case for comparing node values
    
      # find middle of array

      mid = array.length / 2
      #
      root = Node.new(array[mid], array.slice(0, (mid)), array.slice(mid + 1, (array.length - mid)))
      p root
      
      # recursively calling method on left
      left = Tree.new(root.left_child)
      # recursively calling method on right
      right = Tree.new(root.right_child)
    end
    # return level 0 root node
    root
  end
end

# Method to visualize binary search tree
def pretty_print(node = @root, prefix = '', is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
  pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
end

array = [1,2,3,4,5,6,7]

tree = Tree.new(array)

p tree
