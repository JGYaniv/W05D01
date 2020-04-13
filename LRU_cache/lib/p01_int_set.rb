class MaxIntSet
  attr_reader :store

  def initialize(max)
    # max length of array ie if max == 5 =>
    # @store = [false, false, false, false, false]
    #             0      1      2      3      4
    #
    # @store = {0:false, 1:false, 2:false, 3:false, 4:false}
    @store = Array.new(max)
  end

  def insert(num)
    # insert(2) => [false, false, true, false false]
    # insert(2) => {0:false, 1:false, 2:true, 3:false, 4:false}
    if is_valid?(num)
      @store[num] = true
    end
  end

  def remove(num)
    if is_valid?(num)
      @store[num] = false
    end
  end

  def include?(num)
    # [false, false, true, false false]
    # include(2) => true
    # @store[2] = true
    # [false, false, false, false false]
    # include(2) => false
    # @store[2] = false
    if @store[num] && is_valid?(num)
      true
    else
      false
    end
  end

  private

  def is_valid?(num)
    if num >= 0 && num < @store.length
      true
    else
      raise "Out of bounds" 
      false
    end
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20) #num_buckets = 4, num_els = 4 => num_buckets > num_els
    #store => [[0,8,4,16],[],[],[]] 1/4o(n) + 1/4o(n) + 1/4o(n) + 1/4o(n) => 
    #          0   1   2   3
    # insert(0) 
    # insert(8) store[0] << 8
    # insert(4) store[0] << 4
    # insert(4) store[0] << 16
    # include?(16) 16 % 4 => bucket[0].include?(16)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    # if we add this num, will @count > @store.length, if so double the size of the store
    unless include?(num)
      resize! if num_buckets == @count
      @store[num % num_buckets] << (num)
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      @store[num % num_buckets].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    # debugger
    @store[num % num_buckets].include?(num)
  end

  private

  # def [](num)
  #   # optional but useful; return the bucket corresponding to `num`
  # end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2){Array.new}
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % new_store.length] << el
      end
    end
    @store = new_store
  end
end
