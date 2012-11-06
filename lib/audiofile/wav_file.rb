module Audiofile

  ##############################################################################
  #
  #   Using wavfile definition from :
  #   https://ccrma.stanford.edu/courses/422/projects/WaveFormat/
  #
  ##############################################################################

  class WavFile
    attr_reader :raw
    def initialize(filename)
      @file = open(filename).read
      @raw = @file.unpack('a*').first
    end

    def data
      @raw[36..-1]
    end

    def left
      if !@left
        parse_header @raw
        parse_data data
      end
      @left
    end

    def right
      if !@right
        parse_header @raw
        parse_data data
      end
      @right
    end

    def sample_rate
      if !@sample_rate
        parse_header @raw
      end
      @sample_rate
    end

    def bits_per_sample
      if !@bits_per_sample
        parse_header @raw
      end
      @sample_rate
    end

    private
    def parse_header(raw)
      raise "Invalid File" unless raw[0..3] == "RIFF" and raw[8..11] == "WAVE"
      @filesize = raw[4..7].unpack('L<').first + 8
      raise "Please use uncompressed wav" unless
        raw[20..21].unpack('S<').first == 1
      @num_channels = raw[22..23].unpack('S<').first
      @sample_rate = raw[24..27].unpack('L<').first
      @bits_per_sample = raw[34..35].unpack('S<').first
    end


    def parse_data(data)
      raise "Unknown error" unless data[0..3] == "data"
      if @bits_per_sample == 8
        sample_fmt = 'C'
        sample_size = 1
      else
        sample_fmt = 's<'
        sample_size = 2
      end
      @left = []
      @right = []
      i = 8
      bytes_left = data[4..7].unpack('L<').first

      while (i < bytes_left + 8)
        @left << data[i..i+sample_size].unpack(sample_fmt).first
        i += sample_size
        @right << data[i..i+sample_size].unpack(sample_fmt).first
        i += sample_size
      end
    end
  end
end
