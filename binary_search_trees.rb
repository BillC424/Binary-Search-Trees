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
   return 1 if other.nil?
   return -1 if self.nil?
   @data <=> other.data
  end
end

# Class for building out Binary Search Tree
class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    return nil if array.empty?
    return root = Node.new(array[0]) if array.length == 1 
    mid = (array.length / 2)
    root = Node.new(array[mid])
    root.left = build_tree(array.take(mid))
    root.right = build_tree(array.drop(mid + 1))
    root
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

  def insert(value, node = @root)
    return @root = Node.new(value) if @root.nil? 
    return @root if @root.data == value
    return Node.new(value) if node.nil?
    node.left = insert(value, node.left) if value < node.data
    node.right = insert(value, node.right) if value > node.data
    node
  end
  
  def delete(value, node = @root)
    return @root if @root.nil?
    return node = nil if value == node.data && node.left == nil && node.right == nil
    return node = node.right if value == node.data && node.left == nil && node.right != nil 
    return node = node.left if value == node.data && node.right == nil && node.left != nil 
    node.left = delete(value, node.left) if value < node.data 
    node.right = delete(value, node.right) if value > node.data
    node
  end

  def find (value)
    if value < @root.data
     return @root if @root.data == value
     @root = @root.left
     find(value)
    else
      return @root if @root.data == value
      @root = @root.right
      find(value)
    end
  end

end

array = [1,2,3,5,6,8]

tree = Tree.new(array)

tree.delete(2)

p tree

tree.pretty_print

