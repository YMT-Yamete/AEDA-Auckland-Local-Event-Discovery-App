import 'package:aeda/View/filter.dart';
import 'package:aeda/ViewModel/my_feed_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/event_card.dart';

class MyFeed extends StatelessWidget {
  const MyFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final MyFeedViewModel viewModel = Provider.of<MyFeedViewModel>(context);
    viewModel.checkUserInterestsAndNavigate(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "My Feed",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "All Events",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterPage(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.itemCount,
                itemBuilder: (context, index) {
                  return EventCard(
                    event: viewModel.localEventList[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
