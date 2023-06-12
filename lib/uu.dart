import 'package:flutter/material.dart';

class GridSearch extends StatefulWidget {
  @override
  _GridSearchState createState() => _GridSearchState();
}

class _GridSearchState extends State<GridSearch> {
  List<List<String>> _grid = [
    ['A', 'B', 'C', 'D'],
    ['E', 'F', 'G', 'H'],
    ['I', 'J', 'K', 'L'],
    ['M', 'N', 'O', 'P'],
  ];
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Search'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _grid[0].length,
              ),
              itemCount: _grid.length * _grid[0].length,
              itemBuilder: (context, index) {
                int row = index ~/ _grid[0].length;
                int col = index % _grid[0].length;
                String alphabet = _grid[row][col];
                bool isHighlighted = _searchText.contains(alphabet);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _searchText = alphabet;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isHighlighted ? Colors.blue : Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    alignment: Alignment.center,
                    child: Text(alphabet),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value.toUpperCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Text',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GridSearch(),
  ));
}


//! Highlight

// import 'dart:async';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Animated Container')),
//         body: MyWidget(),
//       ),
//     );
//   }
// }

// class MyWidget extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool _isSquare = true;
//   bool _isWordFound = false;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 100),
//     );

//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       });

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _toggleShape() {
//     setState(() {
//       _isSquare = !_isSquare;
//     });

//     if (_isSquare) {
//       _controller.reverse();
//     } else {
//       _controller.forward();
//     }
//   }

//   void _searchWord() {
//     setState(() {
//       _isWordFound = true;
//     });

//     // Simulating search delay
//     Timer(Duration(seconds: 2), () {
//       setState(() {
//         _isWordFound = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: () {
//               _toggleShape();
//             },
//             child: AnimatedContainer(
//               width: _isSquare ? 200 : _animation.value * 200,
//               height: _isSquare ? 200 : _animation.value * 200,
//               decoration: BoxDecoration(
//                 shape: _isSquare ? BoxShape.rectangle : BoxShape.circle,
//                 color: Colors.blue,
//               ),
//               duration: Duration(milliseconds: 100),
//               curve: Curves.easeInOut,
//               child: Center(
//                 child: Text(
//                   'Search',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _searchWord,
//             child: Text('Search Word'),
//           ),
//           SizedBox(height: 20),
//           if (_isWordFound)
//             Text(
//               'Word Found!',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }


//! New one - not working

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Grid Changes Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: GridChangesScreen(),
//     );
//   }
// }

// class GridChangesScreen extends StatefulWidget {
//   @override
//   _GridChangesScreenState createState() => _GridChangesScreenState();
// }

// class _GridChangesScreenState extends State<GridChangesScreen> {
//   List<String> gridLetters = [
//     'A', 'B', 'C', 'D',
//     'E', 'F', 'G', 'H',
//     'I', 'J', 'K', 'L',
//     'M', 'N', 'O', 'P',
//   ];
//   List<bool> highlightedIndexes = List.filled(16, false);
//   TextEditingController wordController = TextEditingController();

//   void onWordChanged(String word) {
//     setState(() {
//       highlightedIndexes = List.filled(16, false);
//       for (int i = 0; i < gridLetters.length; i++) {
//         if (word.contains(gridLetters[i])) {
//           highlightedIndexes[i] = true;
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     wordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Grid Changes Demo'),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             controller: wordController,
//             onChanged: onWordChanged,
//             decoration: InputDecoration(
//               labelText: 'Enter a word',
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               padding: EdgeInsets.all(16),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//               ),
//               itemCount: gridLetters.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   color: highlightedIndexes[index] ? Colors.green : Colors.white,
//                   child: Center(
//                     child: Text(
//                       gridLetters[index],
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: highlightedIndexes[index] ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
