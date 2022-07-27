import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slideshow/models/slider_model.dart';

class DotWidget extends StatelessWidget {
  const DotWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;
    return Container(
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: (pageViewIndex == index) ? Colors.blue : Colors.grey,
          shape: BoxShape.circle),
    );
  }
}
