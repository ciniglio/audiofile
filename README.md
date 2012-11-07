# Audiofile

Parses WAV files lazily. This makes operations much faster than other libraries.

## Installation

Add this line to your application's Gemfile:

    gem 'audiofile'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install audiofile

## Usage

To initialize a file:
    
    a = Audiofile::WavFile.new 'myfile.wav'
    
To get the samples as a string of bytes (great for parsing with C):
    
    d = a.data_chunk
    
To get info about the file:

    a.sample_rate
    a.num_channels
    
To get the left and right channel as array of integers:

    a.left
    a.right

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
