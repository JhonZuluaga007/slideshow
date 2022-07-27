import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slideshow/models/slider_model.dart';
import 'package:slideshow/widgets/dots_widget.dart';
import 'package:slideshow/widgets/slide_widget.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: Scaffold(
        body: Center(
          child: Column(
            children: const [Expanded(child: _Slides()), DotsWidget()],
          ),
        ),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({Key? key}) : super(key: key);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      print('Pagina actual: ${pageViewController.page}');
      //actualizar el provider Slider model
      Provider.of<SliderModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PageView(
        controller: pageViewController,
        children: const [
          SlideWidget(svg: 'assets/svgs/slide-1.svg'),
          SlideWidget(svg: 'assets/svgs/slide-2.svg'),
          SlideWidget(svg: 'assets/svgs/slide-3.svg'),
          SlideWidget(svg: 'assets/svgs/slide-4.svg'),
        ],
      ),
    );
  }
}
