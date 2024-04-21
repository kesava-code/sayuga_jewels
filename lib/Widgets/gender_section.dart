import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sayuga_jewels/Widgets/gender_widget.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

class GenderSection extends StatelessWidget {
  const GenderSection({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = FormFactor().getFormFactor(context);

    int count = screenType == ScreenType.desktop ? 4 : 2;
    double spacing = screenType == ScreenType.desktop
        ? Insets.large
        : screenType == ScreenType.tablet
            ? Insets.medium
            : screenType == ScreenType.handset
                ? Insets.small
                : Insets.xsmall;

    return GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: 2 / 3),
        children: const [
          GenderWidget(genderId: 1, title: "Men", fileName: "man.webp"),
          GenderWidget(genderId: 2, title: "Women", fileName: "woman.webp"),
          GenderWidget(genderId: 3, title: "Girls", fileName: "girl.webp"),
          GenderWidget(genderId: 4, title: "Boys", fileName: "boy.webp")
        ]);
  }
}
