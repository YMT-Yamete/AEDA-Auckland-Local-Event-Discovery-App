import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class BottomWave extends StatelessWidget {
  const BottomWave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipPath(
          clipper: WaveClipperTwo(flip: true, reverse: true),
          child: Container(
            height: 90,
            color: const Color(0xff005EFA),
          ),
        ),
      ],
    );
  }
}
