import 'package:flutter/material.dart';
import 'package:mobigic_test/core/colors/color.dart';
import 'package:mobigic_test/core/fonts/font.dart';
import 'package:mobigic_test/core/sizes/size.dart';
import 'package:mobigic_test/screens/grid_search_screen.dart';
import 'package:mobigic_test/screens/widgets/elevated_button_widget.dart';
import 'package:mobigic_test/screens/widgets/textform_widget.dart';

class GridCreationScreen extends StatefulWidget {
  GridCreationScreen({
    super.key,
    required this.rows,
    required this.columns,
  });

  int rows;
  int columns;

  @override
  State<GridCreationScreen> createState() => _GridCreationScreenState();
}

class _GridCreationScreenState extends State<GridCreationScreen> {
  late List<List<String>> grid;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    grid = List.generate(
      widget.rows,
      (_) => List.filled(widget.columns, ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: appBarColor,
        title: Text(
          'Create Grid',
          style: appBarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                kHeight50,
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: grid.length * grid[0].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: grid[0].length,
                  ),
                  itemBuilder: (context, index) {
                    int row = index ~/ grid[0].length;
                    int col = index % grid[0].length;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: TextFormWidget(
                        maxLength: 1,
                        keyboardType: TextInputType.text,
                        cursorColor: kWhite,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            grid[row][col] = value;
                          });
                        },
                      ),
                    );
                  },
                ),
                kHeight50,
                ElevatedButtonWidget(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GridSearchScreen(grid: grid),
                      ),
                    );
                  },
                  text: 'Create Grid',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
