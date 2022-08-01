import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  const SlideShow(
      {Key? key,
      required this.slides,
      this.indicatorUp = false,
      this.primaryColor = Colors.blue,
      this.secondaryColor = Colors.grey})
      : super(key: key);

  final List<Widget> slides;
  final bool? indicatorUp;
  final Color? primaryColor;
  final Color? secondaryColor;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (BuildContext context) {
              Provider.of<_SlideshowModel>(context).primaryColor =
                  primaryColor!;
              Provider.of<_SlideshowModel>(context).secondaryColor =
                  secondaryColor!;
              return _CreateStructureSlideshow(
                  indicatorUp: indicatorUp, slides: slides);
            },
          ),
        ),
      ),
    );
  }
}

class _CreateStructureSlideshow extends StatelessWidget {
  const _CreateStructureSlideshow({
    Key? key,
    required this.indicatorUp,
    required this.slides,
  }) : super(key: key);

  final bool? indicatorUp;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (indicatorUp!)
          _DotsWidget(
            totalSlides: slides.length,
          ),
        Expanded(
            child: _Slides(
          slides: slides,
        )),
        if (!indicatorUp!)
          _DotsWidget(
            totalSlides: slides.length,
          ),
      ],
    );
  }
}

class _DotsWidget extends StatelessWidget {
  const _DotsWidget({
    Key? key,
    required this.totalSlides,
  }) : super(key: key);

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
  const _DotWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final slideshowModel = Provider.of<_SlideshowModel>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: (slideshowModel.currentPage >= index - 0.5 &&
                  slideshowModel.currentPage < index + 0.5)
              ? slideshowModel.primaryColor
              : slideshowModel.secondaryColor,
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
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
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

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.grey;

  double get currentPage => _currentPage;
  set currentPage(double page) {
    _currentPage = page;
    notifyListeners();
  }

  Color get primaryColor => _primaryColor;
  set primaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }

  Color get secondaryColor => _secondaryColor;
  set secondaryColor(Color color) {
    _secondaryColor = color;
    notifyListeners();
  }
}
