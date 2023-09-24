import 'package:aeda/Widgets/top_back_bar.dart';
import 'package:flutter/material.dart';
import '../Widgets/event_card.dart';

class FilteredPosts extends StatelessWidget {
  const FilteredPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopBackBar(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return EventCard(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
