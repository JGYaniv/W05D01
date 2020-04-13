# require 'Enumerable'

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new(:head,:head_node)
    @tail = Node.new(:tail,:tail_node)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    next_node = @head.next
    until next_node == @tail
      return next_node.val if next_node.key == key
      next_node = next_node.next
    end
    nil
  end

  def include?(key)
    next_node = @head.next
    until next_node == @tail
      return true if next_node.key == key
      next_node = next_node.next
    end
    false
  end

  def append(key, val)
    new_link = Node.new(key, val)
    new_link.prev = @tail.prev
    new_link.next = @tail
    @tail.prev.next = new_link
    @tail.prev = new_link
  end

  def update(key, val)
    next_node = @head.next
    until next_node == @tail
      if next_node.key == key
        next_node.val = val
        return next_node
      end
      next_node = next_node.next
    end
    false
  end

  def remove(key)
    next_node = @head.next
    until next_node == @tail
      if next_node.key == key
        next_node.prev.next = next_node.next
        next_node.next.prev = next_node.prev
        return true
      end
      next_node = next_node.next
    end
    false
  end

  def each(&prc)
    next_node = @head.next
    until next_node == @tail
      prc.call(next_node)
      next_node = next_node.next
    end
    0
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
