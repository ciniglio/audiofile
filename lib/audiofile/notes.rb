module Audiofile
  NOTES = {
    C_0:    16.35,
    CS_0:   17.32,
    D_0:    18.35,
    Eb_0:   19.45,
    E_0:    20.60,
    F_0:    21.83,
    FS_0:   23.12,
    G_0:    24.50,
    GS_0:   25.96,
    A_0:    27.50,
    Bb_0:   29.14,
    B_0:    30.87,
    C_1:    32.70,
    CS_1:   34.65,
    D_1:    36.71,
    Eb_1:   38.89,
    E_1:    41.20,
    F_1:    43.65,
    FS_1:   46.25,
    G_1:    49.00,
    GS_1:   51.91,
    A_1:    55.00,
    Bb_1:   58.27,
    B_1:    61.74,
    C_2:    65.41,
    CS_2:   69.30,
    D_2:    73.42,
    Eb_2:   77.78,
    E_2:    82.41,
    F_2:    87.31,
    FS_2:   92.50,
    G_2:    98.00,
    GS_2:   103.8,
    A_2:    110.0,
    Bb_2:   116.5,
    B_2:    123.5,
    C_3:    130.8,
    CS_3:   138.6,
    D_3:    146.8,
    Eb_3:   155.6,
    E_3:    164.8,
    F_3:    174.6,
    FS_3:   185.0,
    G_3:    196.0,
    GS_3:   207.7,
    A_3:    220.0,
    Bb_3:   233.1,
    B_3:    246.9,
    C_4:    261.6,
    CS_4:   277.2,
    D_4:    293.7,
    Eb_4:   311.1,
    E_4:    329.6,
    F_4:    349.2,
    FS_4:   370.0,
    G_4:    392.0,
    GS_4:   415.3,
    A_4:    440.0,
    Bb_4:   466.2,
    B_4:    493.9,
    C_5:    523.3,
    CS_5:   554.4,
    D_5:    587.3,
    Eb_5:   622.3,
    E_5:    659.3,
    F_5:    698.5,
    FS_5:   740.0,
    G_5:    784.0,
    GS_5:   830.6,
    A_5:    880.0,
    Bb_5:   932.3,
    B_5:    987.8,
    C_6:    1047,
    CS_6:   1109,
    D_6:    1175,
    Eb_6:   1245,
    E_6:    1319,
    F_6:    1397,
    FS_6:   1480,
    G_6:    1568,
    GS_6:   1661,
    A_6:    1760,
    Bb_6:   1865,
    B_6:    1976,
    C_7:    2093,
    CS_7:   2217,
    D_7:    2349,
    Eb_7:   2489,
    E_7:    2637,
    F_7:    2794,
    FS_7:   2960,
    G_7:    3136,
    GS_7:   3322,
    A_7:    3520,
    Bb_7:   3729,
    B_7:    3951,
    C_8:    4186,
    CS_8:   4435,
    D_8:    4699,
    Eb_8:   4978,
    E_8:    5274,
    F_8:    5588,
    FS_8:   5920,
    G_8:    6272,
    GS_8:   6645,
    A_8:    7040,
    Bb_8:   7459,
    B_8:    7902,
  }

  def Audiofile::find_closest_note(freq)
    f = binary_search(freq, Audiofile::NOTES.values)
    Audiofile::NOTES.key(f)
  end

  def Audiofile::binary_search(val, arr)
    s = arr.size
    if s == 1
      arr[0]
    end
    midp = arr[s/2]
    midl = arr[s/2-1]
    if val >= midl and val <= midp
      find_closest(val, midl, midp)
    elsif val < midl
      binary_search(val, arr[0..s/2 - 1])
    else
      binary_search(val, arr[s/2..-1])
    end
  end

  def Audiofile::find_closest(x, y, z)
    if (x-y).abs < (x-z).abs
      y
    else
      z
    end
  end

end
