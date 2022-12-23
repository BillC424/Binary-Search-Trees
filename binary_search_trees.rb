class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other_node)
    data <=> other_node.data
  end
end

class Tree

  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.uniq)
  end

  def build_tree(array)
    # base case
    if array.is_a?(Array) == false 
      nil
    elsif array.length <= 1
      root = Node.new(array[0])
    else  
      # find middle of array
      mid = (array.length / 2)
      #Create root node with left/right children
      root = Node.new(array[mid], array.slice(0, (mid)), array.slice(mid + 1, (array.length - mid)))   
  
      # recursively calling method on left
      root.left = Tree.new(root.left)
      # recursively calling method on right
      root.right = Tree.new(root.right)
    end
    # return level 0 root node
    root
  end
  # Method to visualize binary search tree
  def pretty_print(node = @root, prefix = '', is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
  pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

array = [1,2,3,4,7,5,6,7]

tree = Tree.new(array)

p tree