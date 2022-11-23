class Node

  include Comparable
  # need to read up on Comparable module to determine how to compare nodes using data attribute

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end

  def ==(other_node)
    node.data == other_node.data
  end

end

class Tree

  #maybe this attribute needs to be a method instead? 
  attr_accessor :root

  def initialize(array)
    @array = array
  end 
  
  def build_tree(array)
    #base case

    #recursively calling method on left
    #recursively calling method on left

    # return level-0 root node 
  end

end

array = [1,2,3,4,5,6,7,8,9]