import 'package:aeda/ViewModel/interested_area_viewModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aeda/Data/data.dart';
import 'package:aeda/Widgets/button.dart';
import 'package:aeda/Widgets/top_back_bar.dart';
import 'package:provider/provider.dart';
import '../Widgets/interested_area_select_box.dart';
import '../Widgets/logo_title.dart';

class InterestedAreaPage extends StatefulWidget {
  const InterestedAreaPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InterestedAreaPageState createState() => _InterestedAreaPageState();
}

class _InterestedAreaPageState extends State<InterestedAreaPage> {
  @override
  void initState() {
    super.initState();
    final viewModel =
        Provider.of<InterestedAreaViewModel>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      viewModel.loadUserInterests(user.email!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<InterestedAreaViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TopBackBar(),
                  const LogoTitle(
                    paddingDivider: 50,
                  ),
                  const Text(
                    'Please select your interested area.',
                    style: TextStyle(color: Colors.white),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GridView.count(
                        crossAxisCount: 2,
                        children:
                            List.generate(Data.categories.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              viewModel.toggleSelection(index);
                            },
                            child: InterestedAreaSelectBox(
                              isSelected: viewModel.isSelected,
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
                      viewModel.handleSubmit();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
