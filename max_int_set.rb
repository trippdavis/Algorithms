class MaxIntSet
  attr_reader :count

  def initialize(max)
    self.count, self.store = 0, Array.new(max, false)
  end

  # O(1)
  def include?(number)
    store[number]
  end

  # O(1)
  def insert(number)
    return false if include?(number)

    store[number] = true
    self.count += 1

    true
  end

  # O(1)
  def delete(number)
    return false unless include?(number)

    store[number] = false
    self.count -= 1

    true
  end

  protected
  attr_accessor :store
  attr_writer :count
end
