// ignore: avoid_web_libraries_in_flutter
//import 'dart:html' hide VoidCallback;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    super.key,
    this.color,
    this.onPressed,
  });

  final Color? color;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    

    if (!navigator.canPop()) {
      return const SizedBox.shrink();
    }

    assert(debugCheckHasMaterialLocalizations(context));

    return IconButton(
      icon: const BackButtonIcon(),
      color: color,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          if (kIsWeb) {
           // window.history.back();
          } else {
            GoRouter.of(context).pop();
          }
        }
      },
    );
  }
}
