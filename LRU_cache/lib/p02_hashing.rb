class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    els = self.flatten
    el_sum = 0
    els.each_with_index do |el, idx|
      el_sum += el.hash / (idx+1)*100
    end
    el_sum.hash
  end
end

class String
  def hash
    char_sum = 0
    self.chars.each_with_index{|char, idx| char_sum += char.ord / (idx+1)*100}
    char_sum.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    el_sum = 0
    self.each do |k, v|
      el_sum += (k.hash / v.hash)
    end

    el_sum.hash
  end
end
