import 'package:flutter/material.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/global_variables.dart';

class EmptyScreen extends StatefulWidget {
  final String text1;
  final double size1;
  final String text2;
  final double size2;
  final String text3;
  final double size3;
  final bool useWhite;
  final int turns;
  final bool isLoading;

  const EmptyScreen({
    Key? key,
    required this.text1,
    required this.size1,
    required this.text2,
    required this.size2,
    required this.text3,
    required this.size3,
    this.useWhite = false,
    this.turns = 3,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _EmptyScreenState createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _dotAnimationController;
  late Animation<int> _dotAnimation;

  @override
  void initState() {
    super.initState();

    _dotAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _dotAnimation = IntTween(begin: 0, end: 3).animate(_dotAnimationController);
  }

  @override
  void dispose() {
    _dotAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotatedBox(
              quarterTurns: widget.turns,
              child: Text(
                widget.text1,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: widget.size1,
                  color: widget.useWhite
                      ? AppColors.white
                      : AppColors.colorList[AppGlobals().colorIndex],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text2,
                  style: TextStyle(
                    fontSize: widget.size2,
                    color: widget.useWhite
                        ? AppColors.white
                        : AppColors.colorList[AppGlobals().colorIndex],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AnimatedBuilder(
                  animation: _dotAnimation,
                  builder: (context, child) {
                    String dots = '.' * _dotAnimation.value;
                    return Text(
                      widget.isLoading ? "${widget.text3}$dots" : widget.text3,
                      style: TextStyle(
                        fontSize: widget.size3,
                        fontWeight: FontWeight.w600,
                        color: widget.useWhite ? AppColors.white : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
