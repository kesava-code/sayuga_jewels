import 'package:flutter/material.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

class BestOfSayugaLoadingWindow extends StatelessWidget {
  const BestOfSayugaLoadingWindow({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = FormFactor().getFormFactor(context);
    double borderRadius = screenType == ScreenType.desktop
        ? Insets.extraLarge
        : screenType == ScreenType.tablet
            ? Insets.large
            : screenType == ScreenType.handset
                ? Insets.medium
                : Insets.small;
    double spacing =
        screenType == ScreenType.desktop ? Insets.small : Insets.xsmall;

    return Padding(
      padding: EdgeInsets.all(spacing),
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child:
              ColoredBox(color: Theme.of(context).colorScheme.surfaceVariant)),
    );
  }
}
