import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/logic/cubit/new_for_you_cubit.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

class NewForYouSection extends StatelessWidget {
  const NewForYouSection({super.key});

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
        ? 3
        : screenType == ScreenType.tablet
            ? 3
            : 1;
    double spacing = screenType == ScreenType.desktop
        ? Insets.large
        : screenType == ScreenType.tablet
            ? Insets.medium
            : screenType == ScreenType.handset
                ? Insets.small
                : Insets.xsmall;
    return BlocBuilder<NewForYouCubit, NewForYouState>(
      builder: (context, state) {
        switch (state.status) {
          case NewForYouStatus.failure:
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
          case NewForYouStatus.initial:
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

          case NewForYouStatus.success:
            return GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: 1),
              children: List.generate(
                state.jewelryList.length,
                (index) => MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      if (kIsWeb) {
                        context.go("/jewelry/${state.jewelryList[index].id}");
                      } else {
                        context.push("/jewelry/${state.jewelryList[index].id}");
                      }
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius)),
                      child: Image.network(
                        state.jewelryList[index].mainImage,
                        errorBuilder: (context, error, stackTrace) =>
                            ColoredBox(
                          color: Theme.of(context).colorScheme.errorContainer,
                          child: const Center(),
                        ),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.none,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
