import 'package:flutter/material.dart';

class InkWellOverlay extends StatelessWidget {
  //! inkwell
  const InkWellOverlay({
    Key? key,
    required this.openContainer,
    required this.height,
    required this.child,
  }) : super(key: key);

  final VoidCallback openContainer;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}
