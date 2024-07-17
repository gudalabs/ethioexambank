import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/my_color.dart';

class CustomDashedDivider extends StatelessWidget {
  final double height, width, strokeWidth;
  final Color color;

  const CustomDashedDivider({super.key, required this.height, required this.width, this.color = MyColor.colorDarkGrey, this.strokeWidth = 1});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: DashedDividerPainter(color: color, strokeWidth: strokeWidth),
      ),
    );
  }
}

class DashedDividerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  DashedDividerPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color // Adjust the color of the dashed line as needed
      ..strokeWidth = strokeWidth // Adjust the thickness of the dashed line as needed
      ..strokeCap = StrokeCap.square;

    const double dashWidth = 4;
    const double dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
