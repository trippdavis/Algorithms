class ArraySet
  attr_reader :count

  def initialize
    self.store = []
    self.count = 0
  end

  # O(n)
  def include?(el1)
    store.each do |el2|
      return true if el1 == el2
    end

    false
  end

  # O(n)
  def insert(new_el)
    return false if include?(new_el)

    store << new_el
    self.count += 1

    true
  end

  # O(n)
  def delete(target)
    store.each_with_index do |el, index|
      next unless target == el
      store.delete_at(index)
      self.count -= 1
      return true
    end

    false
  end

  protected
  attr_accessor :store
  attr_writer :count
end
