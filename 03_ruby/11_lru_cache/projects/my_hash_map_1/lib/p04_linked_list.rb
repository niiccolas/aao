class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key  = key
    @val  = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next # connects previous link to next link
    @next.prev = @prev
    @next = @prev = nil # and removes self from list.
    self
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head      = Node.new # sentinel node
    @tail      = Node.new # sentinel node
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |node| return node.val if node.key == key }
    nil
  end

  def include?(key)
    any? { |node| node.key == key }
  end

  def append(key, val)
    new_node = Node.new(key, val)

    @tail.prev.next = new_node
    new_node.prev   = @tail.prev
    new_node.next   = @tail
    @tail.prev      = new_node

    new_node
  end

  def update(key, val)
    each { |link| link.val = val if link.key == key }
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        return node.val
      end
    end

    nil
  end

  def each
    return nil unless block_given?

    node = @head.next
    until node == @tail
      yield node
      node = node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(', ')
  end
end
