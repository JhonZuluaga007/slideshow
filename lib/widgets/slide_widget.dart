import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlideWidget extends StatelessWidget {
  const SlideWidget({Key? key, required this.svg}) : super(key: key);

  final String svg;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: SvgPicture.asset(svg));
  }
}
