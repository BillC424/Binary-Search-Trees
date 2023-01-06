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
    if array.is_a?(Array) == false
      nil
    elsif array.length <= 1
      root = Node.new(array[0])
    else
      # find middle of array
      mid = (array.length / 2)
      # Create root node with left/right children
      root = Node.new(array[mid], array.slice(0, mid), array.slice(mid + 1, (array.length - mid)))

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

  # When inserting a new value in a BST, it always becomes a leaf in the tree. It needs to recursively compare itself to other nodes
  # until a leaf spot (nil) is found
  # If a duplicate value is already present in tree, nothing should be added.
  def insert(value)
    # Base case
    # return if value = @root.data

    if @root.data.nil?
      @root.data = value
      return
    end

    # Need to account for if left or right subtree nodes are nil

    if value < @root.data
      return @root.left = Node.new(value) if @root.left.nil?
      @root.left.insert(value)
    else
      return @root.right = Node.new(value) if @root.right.nil?
      @root.right.insert(value)
    end
  end

  def delete(value)
  
  end
end

array = [1, 2, 4, 5, 6]

tree = Tree.new(array)

tree.insert(3)

p tree