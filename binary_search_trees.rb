# frozen_string_literal: true

# Class for creating Nodes to include in Tree
class Node

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
    return node if node.nil?
    return node = nil if value == node.data && node.left.nil? && node.right.nil?
    return node = node.right if value == node.data && node.left.nil? && !node.right.nil?
    return node = node.left if value == node.data && node.right.nil? && !node.left.nil?
   
    if value == node.data && !node.left.nil? && !node.right.nil?
      array = self.inorder
      next_highest = array[array.index(value) + 1]
      delete(next_highest)
      node.data = next_highest
    end

    node.left = delete(value, node.left) if value < node.data
    node.right = delete(value, node.right) if value > node.data
    node
  end

  def find(value)
    return if @root.nil?
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

 def height(data, height = -1, queue = [])
    return if @root.nil?
    node = data
    node = find(data) if data.is_a?(Integer)
    queue.push(node)
    while queue.empty? == false
      height += 1 
      level_size = queue.size
      
      level_size.times do
        node = queue[0]
        queue.push(node.left) unless node.nil?
        queue.push(node.right) unless node.nil?
        queue.shift
      end
    end
   height
  end

  def depth(value, node = @root, depth = 0)
    return nil if node.nil?
  
    return depth if node.data == value
    left_depth = depth(value, node.left, depth + 1)
    right_depth = depth(value, node.right, depth + 1)
    return left_depth || right_depth
  end
  
 
  def balanced?(node = @root)
    return if node.nil?
    
    return false if height(node.left) - height(node.right) > 1 
    return false if height(node.right) - height(node.left) > 1
    balanced?(node.left) 
    balanced?(node.right) 
    true
  end

  def rebalance!(node = self)
    array = self.inorder
    self.root = build_tree(array)
  end

end

array = [11,53,101,22,23,1,5,6,7,8,55,77,34,56]

tree = Tree.new(array)

tree.delete(23)
tree.pretty_print
