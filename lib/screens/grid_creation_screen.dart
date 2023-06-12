import 'package:flutter/material.dart';
import 'package:mobigic_test/core/colors/color.dart';
import 'package:mobigic_test/core/fonts/font.dart';
import 'package:mobigic_test/core/sizes/size.dart';
import 'package:mobigic_test/screens/grid_display_screen.dart';
import 'widgets/elevated_button_widget.dart';
import 'widgets/textform_widget.dart';

class GridCreationScreen extends StatefulWidget {
  const GridCreationScreen({super.key});

  @override
  State<GridCreationScreen> createState() => _GridCreationScreenState();
}

class _GridCreationScreenState extends State<GridCreationScreen> {
  TextEditingController rowController = TextEditingController();
  TextEditingController columnController = TextEditingController();
  TextEditingController alphabetController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int m = 0;
  int n = 0;
  List<List<String>> grid = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Create a 2D Grid',
          style: appBarTextStyle,
        ),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                kHeight150,
                TextFormWidget(
                  textEditingController: rowController,
                  labelText: 'Enter the number of rows',
                  keyboardType: TextInputType.number,
                  labelStyle: labelTextStyle,
                  cursorColor: kWhite,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Number of rows should not be empty';
                    } else if (int.tryParse(value) == null) {
                      return 'Invalid input. Please enter a valid number.';
                    } else if (int.parse(value) <= 0) {
                      return 'Number of rows should be greater than 0';
                    } else {
                      return null;
                    }
                  },
                ),
                kHeight15,
                TextFormWidget(
                  textEditingController: columnController,
                  labelText: 'Enter the number of columns',
                  keyboardType: TextInputType.number,
                  labelStyle: labelTextStyle,
                  cursorColor: kWhite,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Number of columns should not be empty';
                    } else if (int.tryParse(value) == null) {
                      return 'Invalid input. Please enter a valid number.';
                    } else if (int.parse(value) <= 0) {
                      return 'Number of columns should be greater than 0';
                    } else {
                      return null;
                    }
                  },
                ),
                kHeight100,
                TextFormWidget(
                  textEditingController: alphabetController,
                  labelText: 'Enter Alphabets (separated by comma)',
                  keyboardType: TextInputType.text,
                  labelStyle: labelTextStyle,
                  cursorColor: kWhite,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'This field cannot be empty';
                    } else {
                      return null;
                    }
                  },
                ),
                kHeight20,
                ElevatedButtonWidget(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    setState(() {
                      m = int.parse(rowController.text);
                      n = int.parse(columnController.text);
                      grid = List.generate(m, (i) => List.filled(n, ''));
                    });

                    List<String> alphabets = alphabetController.text
                        .split(',')
                        .map((e) => e.trim())
                        .toList();
                    setState(() {
                      int k = 0;
                      for (int i = 0; i < m; i++) {
                        for (int j = 0; j < n; j++) {
                          if (k < alphabets.length) {
                            grid[i][j] = alphabets[k];
                            k++;
                          }
                        }
                      }
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GridDisplayScreen(grid: grid),
                      ),
                    );
                  },
                  text: 'Display Grid',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
