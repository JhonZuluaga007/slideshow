import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset('assets/svgs/mobile.svg')),
    );
  }
}
