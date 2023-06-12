import 'package:flutter/material.dart';
import 'package:mobigic_test/core/colors/color.dart';
import 'package:mobigic_test/core/fonts/font.dart';
import 'package:mobigic_test/core/sizes/size.dart';
import 'package:mobigic_test/screens/widgets/elevated_button_widget.dart';
import 'package:mobigic_test/screens/widgets/textform_widget.dart';

class GridDisplayScreen extends StatefulWidget {
  final List<List<String>> grid;
  const GridDisplayScreen({super.key, required this.grid});

  @override
  State<GridDisplayScreen> createState() => _GridDisplayScreenState();
}

class _GridDisplayScreenState extends State<GridDisplayScreen> {
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<List<bool>> highlightGrid = [];

  @override
  void initState() {
    super.initState();
    highlightGrid = List.generate(
      widget.grid.length,
      (i) => List.filled(
        widget.grid[0].length,
        false,
      ),
    );
  }

  bool search(String word) {
    bool wordFound = false;
    if (word.isEmpty) {
      return false;
    }
    for (int i = 0; i < widget.grid.length; i++) {
      for (int j = 0; j < widget.grid[i].length; j++) {
        if (searchRight(word, i, j) ||
            searchDown(word, i, j) ||
            searchDiagonal(word, i, j)) {
          wordFound = true;
        }
      }
    }
    return wordFound;
  }

  bool searchRight(String word, int row, int col) {
    if (col + word.length > widget.grid[row].length) {
      return false;
    }
    bool wordFound = true;
    for (int i = 0; i < word.length; i++) {
      if (widget.grid[row][col + i] != word[i]) {
        wordFound = false;
        break;
      }
    }
    if (wordFound) {
      for (int i = 0; i < word.length; i++) {
        highlightGrid[row][col + i] = true;
      }
    }
    return wordFound;
  }

  bool searchDown(String word, int row, int col) {
    if (row + word.length > widget.grid.length) {
      return false;
    }
    bool wordFound = true;
    for (int i = 0; i < word.length; i++) {
      if (widget.grid[row + i][col] != word[i]) {
        wordFound = false;
        break;
      }
    }
    if (wordFound) {
      for (int i = 0; i < word.length; i++) {
        highlightGrid[row + i][col] = true;
      }
    }
    return wordFound;
  }

  bool searchDiagonal(String word, int row, int col) {
    if (row + word.length > widget.grid.length ||
        col + word.length > widget.grid[row].length) {
      return false;
    }
    bool wordFound = true;
    for (int i = 0; i < word.length; i++) {
      if (widget.grid[row + i][col + i] != word[i]) {
        wordFound = false;
        break;
      }
    }

    if (wordFound) {
      for (int i = 0; i < word.length; i++) {
        highlightGrid[row + i][col + i] = true;
      }
    }
    return wordFound;
  }

  void reset() {
    setState(() {
      highlightGrid = List.generate(
        widget.grid.length,
        (i) => List.filled(
          widget.grid[0].length,
          false,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: kWhite,
        ),
        backgroundColor: appBarColor,
        title: Text(
          'Display Grid',
          style: appBarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              kHeight100,
              GridView.builder(
                shrinkWrap: true,
                itemCount: widget.grid.length * widget.grid[0].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.grid[0].length,
                    mainAxisSpacing: 0.8,
                    crossAxisSpacing: 0.8,
                    childAspectRatio: 1.4),
                itemBuilder: (context, index) {
                  int row = index ~/ widget.grid[0].length;
                  int col = index % widget.grid[0].length;
                  return Container(
                    decoration: BoxDecoration(
                      color: highlightGrid[row][col] ? kPurple : kWhite,
                    ),
                    child: Center(
                      child: Text(widget.grid[row][col].toUpperCase()),
                    ),
                  );
                },
              ),
              kHeight50,
              Form(
                key: formKey,
                child: TextFormWidget(
                  textEditingController: searchController,
                  labelText: 'Search here.....',
                  keyboardType: TextInputType.text,
                  labelStyle: labelTextStyle,
                  cursorColor: kWhite,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The field cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    reset();
                    search(value);
                  },
                ),
              ),
              kHeight20,
              ElevatedButtonWidget(
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  if (search(searchController.text)) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Word found',
                            style: alertDialogTitleTextStyle,
                          ),
                          content: Text(
                            'The word is present in the Grid',
                            style: alertDialogContentTextStyle,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Ok',
                                style: alertDialogActionsTextStyle,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Word not found',
                            style: alertDialogTitleTextStyle,
                          ),
                          content: Text(
                            'The word is not present in the Grid',
                            style: alertDialogContentTextStyle,
                          ),
                          actions: [
                            Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  width: 0.2,
                                  color: kPurple,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Ok',
                                  style: alertDialogActionsTextStyle,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                text: 'Search',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
