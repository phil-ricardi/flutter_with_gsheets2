import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../pages/admin_page.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    Key? key,
    required this.closedBuilder,
    required this.transitionType,
  }) : super(key: key);

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (context, openContainer) => const DetailsPage(),
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}
