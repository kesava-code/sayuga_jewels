import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget(
      {super.key,
      required this.genderId,
      required this.title,
      required this.fileName});
  final int genderId;
  final String title;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = FormFactor().getFormFactor(context);
    double borderRadius = screenType == ScreenType.desktop
        ? Insets.large
        : screenType == ScreenType.tablet
            ? Insets.medium
            : screenType == ScreenType.handset
                ? Insets.small
                : Insets.xsmall;
    
    double fontSize = screenType == ScreenType.desktop
        ? 20
        : screenType == ScreenType.tablet
            ? 15
            : screenType == ScreenType.handset
                ? 12
                : 11;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (kIsWeb) {
            context.go("/s?gender__id__in=$genderId");
          } else {
            context.push("/s?gender__id__in=$genderId");
          }
        },
        child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  "assets/images/$fileName",
                  errorBuilder: (context, error, stackTrace) => ColoredBox(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: const Center(),
                  ),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                  height: double.infinity,
                  color: const Color.fromRGBO(0, 0, 0, .4),
                  colorBlendMode: BlendMode.multiply,
                ),
                Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          title,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: fontSize,
                                  shadows: [
                                Shadow(
                                  offset: const Offset(
                                      2.0, 2.0), // Offset the shadow slightly
                                  blurRadius: 10.0, // Apply some blur
                                  color: const Color.fromRGBO(158, 158, 158, 1).withOpacity(
                                      .9), // Semi-transparent gray color
                                )
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
