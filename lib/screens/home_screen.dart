import 'package:flutter/material.dart';
import 'package:mobigic_test/core/colors/color.dart';
import 'package:mobigic_test/core/fonts/font.dart';
import 'package:mobigic_test/core/sizes/size.dart';
import 'package:mobigic_test/screens/grid_creation_screen.dart';
import 'widgets/elevated_button_widget.dart';
import 'widgets/textform_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController rowController = TextEditingController();
  TextEditingController columnController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int m = 0;
  int n = 0;
  List<List<String>> grid = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Create a 2D Grid',
          style: appBarTextStyle,
        ),
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        TextFormWidget(
                          textEditingController: rowController,
                          labelText: 'Enter the number of rows',
                          keyboardType: TextInputType.number,
                          labelStyle: labelTextStyle,
                          cursorColor: kWhite,
                          maxLength: 2,
                          prefixIcon: const Icon(Icons.numbers),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Number of rows should not be empty';
                            } else if (int.tryParse(value) == null) {
                              return 'Invalid input. Please enter a valid number.';
                            } else if (int.parse(value) <= 0 ||
                                int.parse(value) > 7) {
                              return 'Enter a value between 1 - 7';
                            } else {
                              return null;
                            }
                          },
                          textAlign: TextAlign.left,
                        ),
                        kHeight20,
                        TextFormWidget(
                          textEditingController: columnController,
                          labelText: 'Enter the number of columns',
                          keyboardType: TextInputType.number,
                          labelStyle: labelTextStyle,
                          cursorColor: kWhite,
                          maxLength: 2,
                          prefixIcon: const Icon(Icons.numbers),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Number of columns should not be empty';
                            } else if (int.tryParse(value) == null) {
                              return 'Invalid input. Please enter a valid number.';
                            } else if (int.parse(value) <= 0 ||
                                int.parse(value) > 7) {
                              return 'Enter a value between 1 - 7';
                            } else {
                              return null;
                            }
                          },
                          textAlign: TextAlign.left,
                        ),
                        kHeight50,
                        ElevatedButtonWidget(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            setState(() {
                              m = int.parse(rowController.text);
                              n = int.parse(columnController.text);
                              grid =
                                  List.generate(m, (i) => List.filled(n, ''));
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => GridCreationScreen(
                                  rows: m,
                                  columns: n,
                                ),
                              ),
                            );
                          },
                          text: 'Create grid',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
