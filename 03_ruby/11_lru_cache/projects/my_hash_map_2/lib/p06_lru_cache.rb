require_relative '../../my_hash_map_1/lib/p04_linked_list.rb'
require_relative '../../my_hash_map_1/lib/p05_hash_map.rb'

class LRUCache
  def initialize(max, prc)
    @map   = HashMap.new
    @store = LinkedList.new
    @max   = max
    @prc   = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      node = @map[key]
      update_node!(node)
      node.val
    else
      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + "\n" + 'Store: ' + @store.to_s + "\n"
  end

  private

  def calc!(key)
    new_val   = @prc.call(key)
    new_node  = @store.append(key, new_val)
    @map[key] = new_node

    eject! if count > @max
    new_val
  end

  def update_node!(node)
    node.remove
    @map[node.key] = @store.append(node.key, node.val)
  end

  def eject!
    node_to_go = @store.first
    node_to_go.remove
    @map.delete(node_to_go.key)
    nil
  end
end
