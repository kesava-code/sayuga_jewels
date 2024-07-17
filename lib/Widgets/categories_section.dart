import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/logic/cubit/categories_cubit.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

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
    int count = screenType == ScreenType.desktop
        ? 5
        : screenType == ScreenType.tablet
            ? 4
            : screenType == ScreenType.handset
                ? 3
                : 2;
    double fontSize = screenType == ScreenType.desktop
        ? 20
        : screenType == ScreenType.tablet
            ? 15
            : screenType == ScreenType.handset
                ? 12
                : 11;
    double spacing = screenType == ScreenType.desktop
        ? Insets.large
        : screenType == ScreenType.tablet
            ? Insets.medium
            : screenType == ScreenType.handset
                ? Insets.small
                : Insets.xsmall;
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        switch (state.status) {
          case CategoryStatus.failure:
            return SizedBox(
                height: 100,
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Center(
                    child: Text(
                      "Oops! Something went wrong.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onErrorContainer),
                    ),
                  ),
                ));
          case CategoryStatus.initial:
            return GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: 1),
              children: List.generate(
                count,
                (index) => Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                ),
              ),
            );

          case CategoryStatus.success:
            return GridView(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: 1),
              children: List.generate(
                state.categories.length,
                (index) => MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      if (kIsWeb) {
                        context.go(
                            "/s?category__id__in=${state.categories[index].id}");
                      } else {
                        context.push(
                            "/s?category__id__in=${state.categories[index].id}");
                      }
                    },
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius)),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              state.categories[index].image,
                              errorBuilder: (context, error, stackTrace) =>
                                  ColoredBox(
                                color: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
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
                                      state.categories[index].name
                                          .toUpperCase(),
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: fontSize,
                                              shadows: [
                                            Shadow(
                                              offset: const Offset(2.0,
                                                  2.0), // Offset the shadow slightly
                                              blurRadius:
                                                  10.0, // Apply some blur
                                              color: Colors.grey.withOpacity(
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
                ),
              ),
            );
        }
      },
    );
  }
}
