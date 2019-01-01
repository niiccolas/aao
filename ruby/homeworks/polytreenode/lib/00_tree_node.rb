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

  def value
    @value
  end

  def parent=(value)
    if self.parent
      self.parent.children.delete(self)
    end

    @parent = value
    value.children << self unless @parent.nil? || value.children.any? { |child| child == self }

    self
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'Not a child' unless self.children.include?(child_node)

    child_node.parent = nil
  end

  def dfs(target = nil, &prc)
    prc ||= Proc.new { |node| node.value == target }
    return self if prc.call(self)

    children.each do |child|
      search_result = child.dfs(&prc)
      return search_result unless search_result.nil?
    end

    nil
  end

  def bfs(target = nil, &prc)
    prc ||= Proc.new { |node| node.value == target }

    queue = [self]
    until queue.empty?
      node = queue.shift

      return node if prc.call(node)
      queue.concat(node.children)
    end

    nil
  end
end
