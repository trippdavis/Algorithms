class HashSet
  attr_reader :count

  def initialize
    self.buckets = Array.new(8) { [] }
    self.count = 0
  end

  # O(1) randomized
  def include?(obj)
    bucket_for(obj.hash).include?(obj)
  end

  # O(1) ammortized, O(n) worst case
  def insert(obj)
    return false if include?(obj)

    resize! if count == buckets.length
    bucket_for(obj.hash) << obj
    self.count += 1

    true
  end

  # O(1) randomized
  def delete(obj)
    return false unless include?(obj)

    bucket_for(obj.hash).delete(obj)
    self.count -= 1

    true
  end

  protected
  attr_accessor :buckets
  attr_writer :count

  def bucket_for(number)
    buckets[number % buckets.length]
  end

  def resize!
    old_buckets = buckets
    self.buckets = Array.new(old_buckets.length) { [] }
    old_buckets.each do |bucket|
      bucket.each do |el|
        bucket_for(el.hash) << el
      end
    end
  end
end

class Integer
  def hash
    self
  end
end

class Float
  def hash
    self.round
  end
end

class String
  def hash
    h = 0
    self.each_char { |char| h += char.ord }
    h
  end
end

class Array
  def hash
    h = 0
    self.each { |el| h += el.hash }
    h
  end
end

class Hash
  def hash
    self.to_a.hash
  end
end
