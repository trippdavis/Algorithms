require_relative "static_array.rb"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    store[index] = value
  end

  # O(n) worst case, O(1) ammotized
  def push(value)
    resize! if length == capacity

    self.length += 1
    self[length - 1] = value

    nil
  end

  # O(1)
  def pop
    raise "array empty" unless length > 0
    val = self[length - 1]
    self[length - 1] = nil
    self.length -= 1

    val
  end

  # O(n)
  def shift
    raise "array empty" unless length > 0

    val = store[0]

    (1...length).each do |index|
      self[index - 1] = self[index]
    end
    self[length - 1] = nil
    self.length -= 1

    val
  end

  # O(n)
  def unshift(value)
    resize! if length == capacity

    self.length += 1
    (length - 1).downto(1).each do |index|
      self[index] = self[index - 1]
    end
    self[0] = value

    nil
  end


  protected
  attr_accessor :store, :capacity
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= length || index < 0
  end

  # O(n)
  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times{ |i| new_store[i] = self[i] }
    self.capacity = new_capacity
    self.store = new_store
  end
end
