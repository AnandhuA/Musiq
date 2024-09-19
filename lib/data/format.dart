// Modes of crypting / cyphering
enum DESMode { ECB, CBC }

// Types for pad / unpad data
enum DESPaddingType { None, OneAndZeroes, PKCS7, PKCS5 }

// The base class shared by des and triple des.
class _BaseDES {
  final List<int> key;
  final DESMode mode;
  List<int> iv;

  _BaseDES(this.key, this.mode, this.iv) {
    if (iv.length != 8) {
      throw Exception(
          'Invalid Initial Value (iv), must be a multiple of ${DES.BLOCK_SIZE} bytes');
    }
  }
}


class DES {
  static const BLOCK_SIZE = 8;
  static const IV_ZEROS = [0, 0, 0, 0, 0, 0, 0, 0];

  // Type of crypting being done
  static const _ENCRYPT = 0x00;
  static const _DECRYPT = 0x01;

  // Permutation and translation tables for DES
  static const _pc1 = [
    56,
    48,
    40,
    32,
    24,
    16,
    8,
    0,
    57,
    49,
    41,
    33,
    25,
    17,
    9,
    1,
    58,
    50,
    42,
    34,
    26,
    18,
    10,
    2,
    59,
    51,
    43,
    35,
    62,
    54,
    46,
    38,
    30,
    22,
    14,
    6,
    61,
    53,
    45,
    37,
    29,
    21,
    13,
    5,
    60,
    52,
    44,
    36,
    28,
    20,
    12,
    4,
    27,
    19,
    11,
    3
  ];

  // number left rotations of pc1
  static const _leftRotations = [
    1,
    1,
    2,
    2,
    2,
    2,
    2,
    2,
    1,
    2,
    2,
    2,
    2,
    2,
    2,
    1
  ];

  // permuted choice key (table 2)
  static const _pc2 = [
    13,
    16,
    10,
    23,
    0,
    4,
    2,
    27,
    14,
    5,
    20,
    9,
    22,
    18,
    11,
    3,
    25,
    7,
    15,
    6,
    26,
    19,
    12,
    1,
    40,
    51,
    30,
    36,
    46,
    54,
    29,
    39,
    50,
    44,
    32,
    47,
    43,
    48,
    38,
    55,
    33,
    52,
    45,
    41,
    49,
    35,
    28,
    31
  ];

  // initial permutation IP
  static const _ip = [
    57,
    49,
    41,
    33,
    25,
    17,
    9,
    1,
    59,
    51,
    43,
    35,
    27,
    19,
    11,
    3,
    61,
    53,
    45,
    37,
    29,
    21,
    13,
    5,
    63,
    55,
    47,
    39,
    31,
    23,
    15,
    7,
    56,
    48,
    40,
    32,
    24,
    16,
    8,
    0,
    58,
    50,
    42,
    34,
    26,
    18,
    10,
    2,
    60,
    52,
    44,
    36,
    28,
    20,
    12,
    4,
    62,
    54,
    46,
    38,
    30,
    22,
    14,
    6
  ];

  // Expansion table for turning 32 bit blocks into 48 bits
  static const _expansionTable = [
    31,
    0,
    1,
    2,
    3,
    4,
    3,
    4,
    5,
    6,
    7,
    8,
    7,
    8,
    9,
    10,
    11,
    12,
    11,
    12,
    13,
    14,
    15,
    16,
    15,
    16,
    17,
    18,
    19,
    20,
    19,
    20,
    21,
    22,
    23,
    24,
    23,
    24,
    25,
    26,
    27,
    28,
    27,
    28,
    29,
    30,
    31,
    0
  ];

  // The (in)famous S-boxes
  static const _sBox = [
    // S1
    [
      14,
      4,
      13,
      1,
      2,
      15,
      11,
      8,
      3,
      10,
      6,
      12,
      5,
      9,
      0,
      7,
      0,
      15,
      7,
      4,
      14,
      2,
      13,
      1,
      10,
      6,
      12,
      11,
      9,
      5,
      3,
      8,
      4,
      1,
      14,
      8,
      13,
      6,
      2,
      11,
      15,
      12,
      9,
      7,
      3,
      10,
      5,
      0,
      15,
      12,
      8,
      2,
      4,
      9,
      1,
      7,
      5,
      11,
      3,
      14,
      10,
      0,
      6,
      13
    ],

    // S2
    [
      15,
      1,
      8,
      14,
      6,
      11,
      3,
      4,
      9,
      7,
      2,
      13,
      12,
      0,
      5,
      10,
      3,
      13,
      4,
      7,
      15,
      2,
      8,
      14,
      12,
      0,
      1,
      10,
      6,
      9,
      11,
      5,
      0,
      14,
      7,
      11,
      10,
      4,
      13,
      1,
      5,
      8,
      12,
      6,
      9,
      3,
      2,
      15,
      13,
      8,
      10,
      1,
      3,
      15,
      4,
      2,
      11,
      6,
      7,
      12,
      0,
      5,
      14,
      9
    ],

    // S3
    [
      10,
      0,
      9,
      14,
      6,
      3,
      15,
      5,
      1,
      13,
      12,
      7,
      11,
      4,
      2,
      8,
      13,
      7,
      0,
      9,
      3,
      4,
      6,
      10,
      2,
      8,
      5,
      14,
      12,
      11,
      15,
      1,
      13,
      6,
      4,
      9,
      8,
      15,
      3,
      0,
      11,
      1,
      2,
      12,
      5,
      10,
      14,
      7,
      1,
      10,
      13,
      0,
      6,
      9,
      8,
      7,
      4,
      15,
      14,
      3,
      11,
      5,
      2,
      12
    ],

    // S4
    [
      7,
      13,
      14,
      3,
      0,
      6,
      9,
      10,
      1,
      2,
      8,
      5,
      11,
      12,
      4,
      15,
      13,
      8,
      11,
      5,
      6,
      15,
      0,
      3,
      4,
      7,
      2,
      12,
      1,
      10,
      14,
      9,
      10,
      6,
      9,
      0,
      12,
      11,
      7,
      13,
      15,
      1,
      3,
      14,
      5,
      2,
      8,
      4,
      3,
      15,
      0,
      6,
      10,
      1,
      13,
      8,
      9,
      4,
      5,
      11,
      12,
      7,
      2,
      14
    ],

    // S5
    [
      2,
      12,
      4,
      1,
      7,
      10,
      11,
      6,
      8,
      5,
      3,
      15,
      13,
      0,
      14,
      9,
      14,
      11,
      2,
      12,
      4,
      7,
      13,
      1,
      5,
      0,
      15,
      10,
      3,
      9,
      8,
      6,
      4,
      2,
      1,
      11,
      10,
      13,
      7,
      8,
      15,
      9,
      12,
      5,
      6,
      3,
      0,
      14,
      11,
      8,
      12,
      7,
      1,
      14,
      2,
      13,
      6,
      15,
      0,
      9,
      10,
      4,
      5,
      3
    ],

    // S6
    [
      12,
      1,
      10,
      15,
      9,
      2,
      6,
      8,
      0,
      13,
      3,
      4,
      14,
      7,
      5,
      11,
      10,
      15,
      4,
      2,
      7,
      12,
      9,
      5,
      6,
      1,
      13,
      14,
      0,
      11,
      3,
      8,
      9,
      14,
      15,
      5,
      2,
      8,
      12,
      3,
      7,
      0,
      4,
      10,
      1,
      13,
      11,
      6,
      4,
      3,
      2,
      12,
      9,
      5,
      15,
      10,
      11,
      14,
      1,
      7,
      6,
      0,
      8,
      13
    ],

    // S7
    [
      4,
      11,
      2,
      14,
      15,
      0,
      8,
      13,
      3,
      12,
      9,
      7,
      5,
      10,
      6,
      1,
      13,
      0,
      11,
      7,
      4,
      9,
      1,
      10,
      14,
      3,
      5,
      12,
      2,
      15,
      8,
      6,
      1,
      4,
      11,
      13,
      12,
      3,
      7,
      14,
      10,
      15,
      6,
      8,
      0,
      5,
      9,
      2,
      6,
      11,
      13,
      8,
      1,
      4,
      10,
      7,
      9,
      5,
      0,
      15,
      14,
      2,
      3,
      12
    ],

    // S8
    [
      13,
      2,
      8,
      4,
      6,
      15,
      11,
      1,
      10,
      9,
      3,
      14,
      5,
      0,
      12,
      7,
      1,
      15,
      13,
      8,
      10,
      3,
      7,
      4,
      12,
      5,
      6,
      11,
      0,
      14,
      9,
      2,
      7,
      11,
      4,
      1,
      9,
      12,
      14,
      2,
      0,
      6,
      10,
      13,
      15,
      3,
      5,
      8,
      2,
      1,
      14,
      7,
      4,
      10,
      8,
      13,
      15,
      12,
      9,
      0,
      3,
      5,
      6,
      11
    ],
  ];

  // 32-bit permutation function P used on the output of the S-boxes
  static const _p = [
    15,
    6,
    19,
    20,
    28,
    11,
    27,
    16,
    0,
    14,
    22,
    25,
    4,
    17,
    30,
    9,
    1,
    7,
    23,
    13,
    31,
    26,
    2,
    8,
    18,
    12,
    29,
    5,
    21,
    10,
    3,
    24
  ];

  // final permutation IP^-1
  static const _fp = [
    39,
    7,
    47,
    15,
    55,
    23,
    63,
    31,
    38,
    6,
    46,
    14,
    54,
    22,
    62,
    30,
    37,
    5,
    45,
    13,
    53,
    21,
    61,
    29,
    36,
    4,
    44,
    12,
    52,
    20,
    60,
    28,
    35,
    3,
    43,
    11,
    51,
    19,
    59,
    27,
    34,
    2,
    42,
    10,
    50,
    18,
    58,
    26,
    33,
    1,
    41,
    9,
    49,
    17,
    57,
    25,
    32,
    0,
    40,
    8,
    48,
    16,
    56,
    24
  ];

  late _BaseDES _baseDES;
  // 16 48-bit keys (K1 - K16)
  final List<List<int>> _kN = List.filled(16, List.filled(48, 0));

  set iv(List<int> value) => _baseDES.iv = value;
  final DESPaddingType paddingType;

  DES(
      {required List<int> key,
      DESMode mode = DESMode.ECB,
      iv = IV_ZEROS,
      this.paddingType = DESPaddingType.OneAndZeroes}) {
    if (key.length != 8) {
      throw Exception(
          'Invalid DES key size. Key must be exactly 8 bytes long.');
    }

    _baseDES = _BaseDES(key, mode, iv);
    _createSubKeys();
  }

  List<int> _convertToBits(List<int> data) {
    List<int> result = [];
    data.forEach((e) => result += e
        .toRadixString(2)
        .padLeft(8, '0')
        .codeUnits
        .map((el) => el - 48)
        .toList());
    return result;
  }

  List<int> _convertBitsToIntList(List<int> data) {
    List<int> result = [];
    for (int position = 0, c = 0; position < data.length; position++) {
      c += data[position] << (7 - (position % 8));
      if (position % 8 == 7) {
        result.add(c);
        c = 0;
      }
    }
    return result;
  }

  // Permutate this block with the specified table
  List<int> _permutate(List<int> table, List<int> block) =>
      table.map((e) => block[e]).toList();

  // Transform the secret key, so that it is ready for data processing
  // Create the 16 subkeys, K[1] - K[16]
  void _createSubKeys() {
    // Create the 16 subkeys K[1] to K[16] from the given key
    List<int> key = _permutate(_pc1, _convertToBits(_baseDES.key));

    // Split into Left and Right sections
    List<int> left = key.sublist(0, 28);
    List<int> right = key.sublist(28, key.length);
    for (int i = 0; i < 16; i++) {
      // Perform circular left shifts
      for (int j = 0; j < _leftRotations[i]; j++) {
        left.add(left[0]);
        left.removeAt(0);
        right.add(right[0]);
        right.removeAt(0);
      }

      // Create one of the 16 subkeys through pc2 permutation
      _kN[i] = _permutate(_pc2, left + right);
    }
  }

  List<int> xor(List<int> a, List<int>? b) {
    // TODO check lists length
    List<int> result = [];
    for (int i = 0; i < a.length; i++) {
      result.add(a[i] ^ b![i]);
    }
    return result;
  }

  List<int> _desCrypt(List<int> block, int cryptType) {
    block = _permutate(_ip, block);
    List<int> left = block.sublist(0, 32);
    List<int> right = block.sublist(32, block.length);

    int iteration;
    int iterationAdjustment;
    if (cryptType == _ENCRYPT) {
      // Encryption starts from Kn[1] through to Kn[16]
      iteration = 0;
      iterationAdjustment = 1;
    } else {
      // Decryption starts from Kn[16] down to Kn[1]
      iteration = 15;
      iterationAdjustment = -1;
    }

    for (int i = 0; i < 16; i++, iteration += iterationAdjustment) {
      // Make a copy of R[i-1], this will later become L[i]
      List<int> tempRight = List.from(right);

      // Permutate R[i - 1] to start creating R[i]
      right = _permutate(_expansionTable, right);

      // Exclusive or R[i - 1] with K[i], create B[1] to B[8] whilst here
      right = xor(right, _kN[iteration]);
      List<List<int>> B = [
        right.sublist(0, 6),
        right.sublist(6, 12),
        right.sublist(12, 18),
        right.sublist(18, 24),
        right.sublist(24, 30),
        right.sublist(30, 36),
        right.sublist(36, 42),
        right.sublist(42)
      ];
      List<int> bN = List.filled(32, 0);
      for (int j = 0, position = 0; j < 8; j++, position += 4) {
        // Work out the offsets
        int m = (B[j][0] << 1) + B[j][5];
        int n = (B[j][1] << 3) + (B[j][2] << 2) + (B[j][3] << 1) + B[j][4];

        // Find the permutation value
        int v = _sBox[j][(m << 4) + n];

        // Turn value into bits, add it to result: Bn
        bN[position] = (v & 8) >> 3;
        bN[position + 1] = (v & 4) >> 2;
        bN[position + 2] = (v & 2) >> 1;
        bN[position + 3] = v & 1;
      }

      // Permutate the concatenation of B[1] to B[8] (Bn)
      right = _permutate(_p, bN);

      // Xor with L[i - 1]
      right = xor(right, left);

      left = tempRight;
    }

    // Final permutation of R[16]L[16]
    return _permutate(_fp, right + left);
  }

  List<int> crypt(List<int> data, int cryptType) {
    List<int>? iv;
    List<int> processedBlock;
    // Error check the data
    if (data.isEmpty) {
      return [];
    }
    if (data.length % BLOCK_SIZE != 0) {
      if (cryptType == _DECRYPT) {
        // Decryption must work on 8 byte blocks
        throw Exception(
            'Invalid data length, data must be a multiple of $BLOCK_SIZE bytes.');
      }
    }
    if (_baseDES.mode == DESMode.CBC) {
      iv = _convertToBits(_baseDES.iv);
    }

    // Split the data into blocks, crypting each one separately
    int i = 0;
    List<int> result = [];
    while (i < data.length) {
      List<int> block = _convertToBits(data.sublist(i, i + 8));
      // Xor with IV if using CBC mode
      if (_baseDES.mode == DESMode.CBC) {
        if (cryptType == _ENCRYPT) {
          block = xor(block, iv);
        }
        processedBlock = _desCrypt(block, cryptType);
        if (cryptType == _DECRYPT) {
          processedBlock = xor(processedBlock, iv);
          iv = block;
        } else {
          iv = processedBlock;
        }
      } else {
        processedBlock = _desCrypt(block, cryptType);
      }

      result += _convertBitsToIntList(processedBlock);
      i += 8;
    }

    return result;
  }

  List<int> encrypt(List<int> data) => //crypt(data, _ENCRYPT);
      crypt(DESPadding.pad(data, paddingType), _ENCRYPT);
  List<int> decrypt(List<int> data) => //crypt(data, _DECRYPT);
      DESPadding.unpad(crypt(data, _DECRYPT), paddingType);
}



class DESPadding {
  static List<int> pad(List<int> data, DESPaddingType paddingType) {
    if (paddingType == DESPaddingType.OneAndZeroes) {
      return _oneAndZerosPad(data);
    } else if (paddingType == DESPaddingType.PKCS7) {
      return _pkcs7Pad(data);
    } else if (paddingType == DESPaddingType.PKCS5) {
      return _pkcs5Pad(data);
    }

    return data;
  }

  static List<int> unpad(List<int> block, DESPaddingType paddingType) {
    if (paddingType == DESPaddingType.OneAndZeroes) {
      return _oneAndZerosUnpad(block);
    } else if (paddingType == DESPaddingType.PKCS7) {
      return _pkcs7Unpad(block);
    } else if (paddingType == DESPaddingType.PKCS5) {
      return _pkcs5Unpad(block);
    }

    return block;
  }


  static List<int> _oneAndZerosPad(List<int> data) {
    final padding = [0x80] + List.generate(7, (index) => 0);
    final size = padding.length;
    final left = size - (data.length % size);
    return data + padding.sublist(0, left);
  }

  static List<int> _oneAndZerosUnpad(List<int> data) {
    List<int> reversed = List.from(data.reversed);
    int l = 0;
    while (reversed[l] == 0x00) {
      l += 1;
    }
    if (reversed[l] == 0x80) {
      return data.sublist(0, data.length - (l + 1));
    } else {
      return data;
    }
  }

  static List<int> _pkcs7Pad(List<int> data, {int blockSize = 8}) {
    if (blockSize < 1 || blockSize > 255) {
      throw Exception('PKCS7 block size must be in range 1..255');
    }

    final left = blockSize - (data.length % blockSize);
    final padding = List.generate(left, (index) => left);
    return data + padding.sublist(0, left);
  }

  static List<int> _pkcs7Unpad(List<int> data) {
    List<int> reversed = List.from(data.reversed);
    final paddingSize = reversed.first;
    for (int i = 0; i < paddingSize; i++) {
      if (reversed[i] != paddingSize) {
        return data;
      }
    }
    return data.sublist(0, data.length - (paddingSize));
  }

  static List<int> _pkcs5Pad(List<int> data) => _pkcs7Pad(data, blockSize: 8);

  static List<int> _pkcs5Unpad(List<int> data) => _pkcs7Unpad(data);
}
