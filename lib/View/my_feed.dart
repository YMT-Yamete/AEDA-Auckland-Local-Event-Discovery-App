import 'package:aeda/View/filter.dart';
import 'package:aeda/ViewModel/my_feed_viewModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/event_card.dart';

class MyFeed extends StatefulWidget {
  const MyFeed({Key? key});

  @override
  State<MyFeed> createState() => _MyFeedState();
}

class _MyFeedState extends State<MyFeed> {
  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<MyFeedViewModel>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      viewModel.refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final MyFeedViewModel viewModel = Provider.of<MyFeedViewModel>(context);
    viewModel.checkUserInterestsAndNavigate(context);

    Future<void> _handleRefresh() async {
      await viewModel.refreshData();
    }

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
                        child: const Text(
                          "My Feed",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FilterPage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            if (viewModel.isLoading)
              const Expanded(
                child: Center(
                  child:
                      CircularProgressIndicator(), // Show a loading indicator.
                ),
              )
            else if (viewModel.itemCount == 0)
              const Expanded(
                child: Center(
                  child: Text(
                    "No events to display.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: ListView.builder(
                    itemCount: viewModel.itemCount,
                    itemBuilder: (context, index) {
                      return EventCard(
                        event: viewModel.localEventList[index],
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
