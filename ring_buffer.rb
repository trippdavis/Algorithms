class RingBuffer
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.length = 0
    self.capacity = 8
    self.start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    store[(start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    store[(start_idx + index) % capacity] = value
  end

  # O(1)
  def pop
    raise "array empty" unless length > 0

    val = self[length - 1]
    self[length - 1] = nil
    self.length -= 1

    val
  end

  # O(n) worst case, O(1) ammortized
  def push(value)
    resize! if length == capacity

    self.length += 1
    self[length - 1] = value

    nil
  end

  # O(1)
  def shift
    raise "array empty" unless length > 0

    val = self[0]
    self[0] = nil
    self.start_idx = (self.start_idx + 1) % capacity
    self.length -= 1

    val
  end

  # O(n) worst case, O(1) ammortized
  def unshift(value)
    resize! if length == capacity

    self.length += 1
    self.start_idx = (self.start_idx == 0 ? capacity - 1 : self.start_idx - 1)
    self[0] = value

    nil
  end



  protected
  attr_accessor :store, :capacity, :start_idx
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= length || index < 0
  end

  # O(n)
  def resize!
    new_capacity = self.capacity * 2
    new_store = StaticArray.new(new_capacity)
    length.times{|i| new_store[i] = self[i]}
    self.start_idx = 0
    self.capacity = new_capacity
    self.store = new_store
  end
end
