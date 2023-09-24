import 'package:aeda/Widgets/button.dart';
import 'package:flutter/material.dart';

import '../Widgets/interested_area_select_box.dart';
import '../Widgets/logo_title.dart';

class InterestedAreaPage extends StatefulWidget {
  const InterestedAreaPage({Key? key}) : super(key: key);

  @override
  _InterestedAreaPageState createState() => _InterestedAreaPageState();
}

class _InterestedAreaPageState extends State<InterestedAreaPage> {
  List<bool> isSelected =
      List.generate(5, (index) => false); // TODO: Change Index Size

  void toggleSelection(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoTitle(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(5, (index) {
                          // TODO: Change List Size to Total Data Count
                          return GestureDetector(
                            onTap: () {
                              toggleSelection(index);
                            },
                            child: InterestedAreaSelectBox(
                              isSelected: isSelected,
                              index: index,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Button(
                      labelText: 'Submit',
                      onPressed: () {
                        // TODO: Save the Selected Types into Db
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
