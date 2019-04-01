class LRUCache
  def initialize(cache_size)
    @cache      = []
    @cache_size = cache_size
  end

  def count
    @cache.size
  end

  def add(el)
    @cache.shift   if count == @cache_size
    @cache -= [el] if @cache.include? el
    @cache << el
  end

  def show
    print @cache
  end
end
