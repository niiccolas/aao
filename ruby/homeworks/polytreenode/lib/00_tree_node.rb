class PolyTreeNode
  def initialize(value)
    @value    = value
    @parent   = nil
    @children = []
  end

  attr_reader :value, :parent, :children

  def parent=(node)
    parent.children.delete(self) unless parent.nil?

    @parent = node
    node.children << self unless @parent.nil?
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

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value

      queue.concat(node.children)
    end
  end
end
