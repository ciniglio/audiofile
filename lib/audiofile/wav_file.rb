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

    def data_chunk
      chunks.select{|c| c.name == "data"}.first.payload
    end

    def fmt_chunk
      chunks.select{|c| c.name == "fmt "}.first.payload
    end

    def left
      if !@left
        parse_header
        parse_data data
      end
      @left
    end

    def right
      if !@right
        parse_header
        parse_data data
      end
      @right
    end

    def sample_rate
      if !@sample_rate
        parse_header
      end
      @sample_rate
    end

    def bits_per_sample
      if !@bits_per_sample
        parse_header
      end
      @bits_per_sample
    end

    def num_channels
      if !@num_channels
        parse_header
      end
      @num_channels
    end

    def filesize
      if !@filesize
        parse_header
      end
      @filesize
    end

    def chunks
      if !@chunks
        chunk
      end
      @chunks
    end

    private
    def parse_header
      raise "Please use uncompressed wav" unless
        fmt_chunk[0..1].unpack('S<').first == 1
      @num_channels = fmt_chunk[2..3].unpack('S<').first
      @sample_rate = fmt_chunk[4..7].unpack('L<').first
      @bits_per_sample = fmt_chunk[14..15].unpack('S<').first
    end

    def chunk
      raise "Invalid File" unless @raw[0..3] == "RIFF" and @raw[8..11] == "WAVE"
      @filesize = @raw[4..7].unpack('L<').first + 8
      counter = 12
      @chunks = []
      while counter < filesize
        name = @raw[counter..counter+3]
        size = @raw[counter+4..counter+7].unpack('L<').first
        payload = @raw[counter+8..counter+8+size-1]
        counter += 8 + size
        @chunks << Chunk.new(name, size, payload)
      end
    end

    def parse_data
      if @bits_per_sample == 8
        sample_fmt = 'C'
        sample_size = 1
      else
        sample_fmt = 's<'
        sample_size = 2
      end
      @left = []
      @right = []
      bytes_left = data_chunk.size

      while (i < bytes_left)
        @left << data[i..i+sample_size].unpack(sample_fmt).first
        i += sample_size
        @right << data[i..i+sample_size].unpack(sample_fmt).first
        i += sample_size
      end
    end
  end

  class Chunk
    attr_accessor :name, :size, :payload

    def initialize(name, size, payload)
      @name = name
      @size = size
      @payload = payload
    end
  end
end
