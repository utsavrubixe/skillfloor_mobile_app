import 'dart:async';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  final List<String> imageUrls;
  final Duration duration;

  const BannerSlider({
    Key? key,
    required this.imageUrls,
    this.duration = const Duration(seconds: 5),
  }) : super(key: key);

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _startSlider();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startSlider() {
    Timer.periodic(widget.duration, (Timer timer) {
      if (_currentPage < widget.imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Adjust the height according to your design
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildBanner(widget.imageUrls[index]);
        },
        onPageChanged: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }

  Widget _buildBanner(String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
