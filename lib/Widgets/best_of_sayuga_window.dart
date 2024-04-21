import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

class BestOfSayugaWindow extends StatelessWidget {
  const BestOfSayugaWindow({super.key, required this.id, required this.url});
  final String id;
  final String url;

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
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (kIsWeb) {
              context.go("/jewelry/$id");
            } else {
              context.push("/jewelry/$id");
            }
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
