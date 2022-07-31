import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slideshow/models/slider_model.dart';

class SlideShow extends StatelessWidget {
  const SlideShow({Key? key, required this.slides}) : super(key: key);

  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: Center(
        child: Column(
          children: [
            Expanded(
                child: _Slides(
              slides: slides,
            )),
            _DotsWidget(
              totalSlides: slides.length,
            )
          ],
        ),
      ),
    );
  }
}

class _DotsWidget extends StatelessWidget {
  const _DotsWidget({Key? key, required this.totalSlides}) : super(key: key);

  final int totalSlides;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              totalSlides,
              (index) => _DotWidget(
                    index: index,
                  ))),
    );
  }
}

class _DotWidget extends StatelessWidget {
  const _DotWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
              ? Colors.blue
              : Colors.grey,
          shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({Key? key, required this.slides}) : super(key: key);

  final List<Widget> slides;

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      Provider.of<SliderModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PageView(
        controller: pageViewController,
        children: widget.slides
            .map((slide) => _SlideWidget(
                  slide: slide,
                ))
            .toList(),
      ),
    );
  }
}

class _SlideWidget extends StatelessWidget {
  const _SlideWidget({Key? key, required this.slide}) : super(key: key);

  final Widget slide;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: slide);
  }
}
