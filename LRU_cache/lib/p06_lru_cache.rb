require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @store.include?(key) #means it  is recently used
      update_node!(key)
    else #means it is not recently used
      eject! if count == @max
      @store.append(key, calc!(key))
      @map.set(key, @store.last)
      @store.get(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(key)
    # suggested helper method; move a node to the end of the list
    val = @store.get(key)
    @store.remove(key)
    @store.append(key, val)
    val
  end

  def eject!
    lru_el = @store.first.key
    @store.remove(lru_el)
    @map.delete(lru_el)
  end
end
