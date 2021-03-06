class XO_Utils {
  static final winningSituations = [
    [
      [0, 0],
      [0, 1],
      [0, 2]
    ],
    [
      [1, 0],
      [1, 1],
      [1, 2]
    ],
    [
      [2, 0],
      [2, 1],
      [2, 2]
    ],
    [
      [0, 0],
      [1, 0],
      [2, 0]
    ],
    [
      [0, 1],
      [1, 1],
      [2, 1]
    ],
    [
      [0, 2],
      [1, 2],
      [2, 2]
    ],
    [
      [0, 0],
      [1, 1],
      [2, 2]
    ],
    [
      [0, 2],
      [1, 1],
      [2, 0]
    ],
  ];

  static int flatten2DIndexes(int r, int c) => (r * 3) + c;
  static List<int> unflatten2DIndexes(int index) => [index ~/ 3, index % 3];

  static List<String> flatten2DArray(List<List<String>> grid) {
    return grid.fold([], (previousValue, row) => [...previousValue, ...row]);
  }

  static List<List<String>> unFlatten2DGrid(List<String> array) {
    List<List<String>> grid = [];
    for (int i = 0; i < 9; i += 3) {
      grid.add(array.sublist(i, i + 3));
    }
    return grid;
  }
}
