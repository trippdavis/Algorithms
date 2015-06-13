class StaticArray
  def initialize(length)
    self.store = Array.new(length, nil)
    self.length = length
  end

  # 0(1)
  def [](index)
    check_index(index)
    store[index]
  end

  # 0(1)
  def []=(index, value)
    check_index(index)
    store[index] = value
  end

  protected
  attr_accessor :store, :length

  def check_index(index)
    raise "index out of bounds" if index >= length || index < 0
  end
end
