import 'package:aeda/Data/data.dart';
import 'package:flutter/material.dart';

class InterestedAreaSelectBox extends StatelessWidget {
  const InterestedAreaSelectBox(
      {super.key, required this.isSelected, required this.index});

  final List<bool> isSelected;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected[index]
                  ? const Color(0xff005EFA)
                  : Colors.transparent,
              width: 4.0,
            ),
          ),
          child: Image.asset(
            'assets/images/place_holder_img.jpg',
            width: 120,
            height: 120,
          ),
        ),
        Text(
          Data.categories[index],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
