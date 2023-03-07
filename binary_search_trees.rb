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
    return -1 if nil?

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
    return node = nil if value == node.data && node.left.nil? && node.right.nil?
    return node = node.right if value == node.data && node.left.nil? && !node.right.nil?
    return node = node.left if value == node.data && node.right.nil? && !node.left.nil?

    # Need to add return statement for if a node has two children once inorder method is built out

    node.left = delete(value, node.left) if value < node.data
    node.right = delete(value, node.right) if value > node.data
    node
  end

  def find(value)
    return @root if @root.data == value

    @root = if value < @root.data

              @root.left
            else

              @root.right
            end
    find(value)
  end

  def levelorder(node = @root, queue = [], values_array = [])
    return if @root.nil?

    queue.push(node)
    while queue.empty? == false
      node = queue[0]
      yield queue[0] if block_given?
      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
      values_array.push(node.data)
      queue.shift
    end
    return values_array if block_given? == false
  end

  def preorder(node = @root, values_array = [], &blk)
    return if node.nil?

    values_array.push(node.data)
    blk.call(node) if block_given?
    preorder(node.left, values_array, &blk)
    preorder(node.right, values_array, &blk)
    return values_array if block_given? == false
  end

  def inorder(node = @root, values_array = [], &blk)
    return if node.nil?

    inorder(node.left, values_array, &blk)
    values_array.push(node.data)
    blk.call(node) if block_given?
    inorder(node.right, values_array, &blk)
    return values_array if block_given? == false
  end

  def postorder(node = @root, values_array = [], &blk)
    return if node.nil?

    postorder(node.left, values_array, &blk)
    postorder(node.right, values_array, &blk)
    values_array.push(node.data)
    blk.call(node) if block_given?
    return values_array if block_given? == false
  end

  def height(node, counter = 0)
    
    #once a leaf node is hit, return with the sum of the counter variable
    #counter starts at node and ends when longest path to a leaf node is found

  end

  def depth(value, node = @root, counter = 0)
    return if node.nil?
    
    return p "The depth is #{counter}" if node.data == value
    counter = counter + 1
    depth(value, node.left, counter)
    depth(value, node.right, counter)
    nil
  end
end

array = [8, 3, 4, 2, 7, 11]

tree = Tree.new(array)

p tree

tree.depth(8)

tree.pretty_print
