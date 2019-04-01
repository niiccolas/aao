require 'lru_cache'

describe 'LRUCache' do
  let(:wu_cache_size) { 4 }
  subject(:wu_cache) { LRUCache.new(wu_cache_size) }

  before do
    wu_cache.add(1993)
    wu_cache.add(36)
    wu_cache.add('C.R.E.A.M.')
    wu_cache.add('Da Mystery Of Chessboxin')
    wu_cache.add(year: 1993, label: 'RCA')
    wu_cache.add('Can It Be All So Simple')
    wu_cache.add('C.R.E.A.M.')
  end

  describe '#count' do
    it 'returns number of elements currently in cache' do
      expect(wu_cache.count).to eq(4)
      expect(wu_cache.count).not_to eq(6)
    end
  end

  describe '#add(el)' do
    it 'adds element to cache' do
      expect(wu_cache.count).to eq(4)
    end

    it 'adds according to the LRU principle' do
      expect(wu_cache.instance_variable_get(:@cache)).not_to include(36)
      expect(wu_cache.instance_variable_get(:@cache)).not_to include(1993)
      expect(wu_cache.instance_variable_get(:@cache).last).to eq('C.R.E.A.M.')
    end
  end

  describe '#show' do
    it 'shows items in the cache' do
      expect { wu_cache.show }.to output("[\"Da Mystery Of Chessboxin\", {:year=>1993, :label=>\"RCA\"}, \"Can It Be All So Simple\", \"C.R.E.A.M.\"]").to_stdout
    end

    it 'shows the LRU item first' do
      expect(wu_cache.instance_variable_get(:@cache).first).to eq('Da Mystery Of Chessboxin')
    end
  end
end