# :nodoc:
class Array
  def my_each(&block)
    self.length.times do |idx|
      block.call(self[idx])
    end

    self
  end

  def my_select(&block)
    selects = []

    self.my_each do |el|
      selected << el if block.call(el)
    end

    selects
  end

  def my_reject(&block)
    rejects = []

    self.each do |el|
      rejects << el unless block.call(el)
    end

    rejects
  end
end