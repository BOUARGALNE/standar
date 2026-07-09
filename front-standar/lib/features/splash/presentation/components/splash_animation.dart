import 'package:flutter/material.dart';

class SplashAnimation extends StatefulWidget {
  final double width;
  final double height;
  final Color containerColor;
  final Color pillColor;
  final Color borderColor;

  const SplashAnimation({
    super.key,
    this.width = 180,
    this.height = 50,
    this.containerColor = const Color(0xFFFF0000),
    this.pillColor = const Color(0xFFFF0000),
    this.borderColor = Colors.transparent,
  });

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double pillWidth = widget.width * 0.5;

    return Container(
      width: widget.width,
      height: widget.height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: widget.containerColor,
        borderRadius: BorderRadius.circular(widget.height / 2),
        border: Border.all(color: widget.borderColor, width: 3),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                left:
                    -pillWidth + _controller.value * (widget.width + pillWidth),
                top: 1,
                bottom: 1,
                child: child!,
              ),
            ],
          );
        },
        child: Container(
          width: pillWidth,
          height: 10,
          decoration: BoxDecoration(
            color: widget.pillColor,
            borderRadius: BorderRadius.circular(widget.height / 2),
          ),
          /* child: SvgPicture.asset(
          AppAssets.carIcon,
          width: pillWidth + 10,
          colorFilter: ColorFilter.mode(widget.pillColor, BlendMode.srcIn),
        ),*/
        ),
      ),
    );
  }
}
