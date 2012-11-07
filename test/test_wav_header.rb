require_relative './test_helper.rb'

Dir.chdir(File.dirname(__FILE__))
WAVFILE = 'test.wav'

class TestWavHeader < Test::Unit::TestCase
  def test_headers
    w = Audiofile::WavFile.new WAVFILE
    assert_equal w.sample_rate, 44100
    assert_equal w.bits_per_sample, 16
    assert_equal w.num_channels, 2
    assert_equal w.filesize, File.size(WAVFILE)
  end
end
