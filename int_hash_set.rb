class IntHashSet
  attr_reader :count

  def initialize
    self.buckets = Array.new(8) { [] }
    self.count = 0
  end

  # O(1) randomized
  def include?(number)
    bucket_for(number).include?(number)
  end

  # O(1) ammortized, O(n) worst case
  def insert(number)
    return false if include?(number)

    resize! if count == buckets.length
    bucket_for(number) << number
    self.count += 1
    true
  end

  # O(1)
  def delete(number)
    return false unless include?(number)
    bucket_for(number).delete(number)
    self.count -= 1
    true
  end


  protected
  attr_accessor :buckets
  attr_writer :count

  def bucket_for(number)
    buckets[number % buckets.size]
  end

  # O(n)
  def resize!
    old_buckets = buckets
    self.buckets = Array.new(old_buckets.size * 2) { [] }
    old_buckets.each do |bucket|
      bucket.each do |num|
        bucket_for(num) << num
      end
    end
  end
end
