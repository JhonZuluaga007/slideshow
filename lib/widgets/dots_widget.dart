import 'package:flutter/material.dart';
import 'package:slideshow/widgets/dot_widget.dart';

class DotsWidget extends StatelessWidget {
  const DotsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          DotWidget(index: 0),
          DotWidget(index: 1),
          DotWidget(index: 2),
          DotWidget(index: 3),
        ],
      ),
    );
  }
}
