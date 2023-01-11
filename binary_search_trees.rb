# frozen_string_literal: true

# Class for creating Nodes to include in Tree
class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    data <=> other.data
  end
end

# Class for building out Binary Search Tree
class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    # base case
    p array
    if array.length <= 1 
      root = Node.new(array[0]) #unless array.empty?
    else
      # find middle of array
      mid = (array.length / 2)
      # Create root node with left/right children

      #If I undestand how this works better I may be able to move on 
      root = Node.new(array[mid], array.slice(0, mid), array.slice(mid + 1, (array.length - mid))) 

      # recursively calling method on left
      root.left = Tree.new(root.left) if root.left != []
      # recursively calling method on right
      root.right = Tree.new(root.right) if root.right != []
    end
    # return level 0 root node
    p root
  end

  # Method to visualize binary search tree
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  # When inserting a new value in a BST, it always becomes a leaf in the tree. It needs to recursively compare itself to other nodes
  # until a leaf spot (nil) is found
  # If a duplicate value is already present in tree, nothing should be added.
  def insert(value)
    # Base case
    if @root.data.nil?
      @root.data = value
      return
    end
    # Recursive case
    if value < @root.data
      return @root.left = Node.new(value) if @root.left.nil?
      @root.left.insert(value)
    else
      return @root.right = Node.new(value) if @root.right.nil?
      @root.right.insert(value)
    end
  end

  def delete(value)
    if value < @root.data
      delete_with_one_child(value)
      return @root.left = nil if @root.left.root.data == value
      @root.left.delete(value)
    else
      delete_with_one_child(value)
      return @root.right = nil if @root.right.root.data == value
      @root.right.delete(value)
    end
  end

  def delete_with_one_child(value)
    return @root = @root.left if @root.right = nil && @root.data == value
    return @root = @root.right if @root.left = nil && @root.data == value
  end

  def find (value)
    if value < @root.data
     return @root if @root.data == value
     @root.left.find(value)
    else
      return @root if @root.data == value
      @root.right.find(value)
    end
  end

end

#case
#when @root.left != nil && @root.right != nil
#when @root.left == nil || @root.right == nil
#  when @root.left == nil && @root.right == nil
#end



array = [1,2,3,4,5,6]

tree = Tree.new(array)

#tree.delete(6)

p tree