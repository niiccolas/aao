class PolyTreeNode
  attr_accessor :children

  def initialize(value)
    @value    = value
    @parent   = nil
    @children = []
  end

  def parent
    @parent
  end

  def parent=(value)
    if self.parent
      self.parent.children.delete(self)
    end

    @parent = value
    value.children << self unless @parent.nil? || value.children.any? { |child| child == self }

    self
  end

  def value
    @value
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'Not a child' unless self.children.include?(child_node)

    child_node.parent = nil
  end
end
