import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

class FlexibleSpaceWidget extends StatelessWidget {
  const FlexibleSpaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = FormFactor().getFormFactor(context);

    return FlexibleSpaceBar(
      expandedTitleScale: screenType == ScreenType.tablet ? 1.2 : 1.5,
      titlePadding: screenType == ScreenType.tablet
          ? const EdgeInsets.symmetric(horizontal: 60, vertical: 0)
          : null,
      collapseMode: CollapseMode.none,
      title: screenType == ScreenType.desktop
          ? MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).go("/");
                },
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SelectionContainer.disabled(
                        child: Text(
                          "Sayuga",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                      )
                    ]),
              ),
            )
          : screenType == ScreenType.tablet
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go("/");
                    },
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                      height: 30,
                      width: 30,
                    ),
                  ),
                )
              : null,
    );
  }
}
