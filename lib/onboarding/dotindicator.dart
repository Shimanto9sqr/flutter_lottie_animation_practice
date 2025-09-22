import 'package:flutter/material.dart';
class DotIndicator extends StatelessWidget {
  final bool isSelected;
  const DotIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(right: 6.0),
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 6.0,
            width: 6.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected? Colors.black: Colors.grey,
            ),
        ),
    );
  }
}
