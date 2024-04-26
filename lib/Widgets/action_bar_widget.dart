import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

class ActionBarWidget extends StatefulWidget {
  const ActionBarWidget({super.key, required this.isHome, required this.index});
  final int index;
  final bool isHome;

  @override
  State<ActionBarWidget> createState() => _ActionBarWidgetState();
}

class _ActionBarWidgetState extends State<ActionBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = FormFactor().getFormFactor(context);
    double spacing = screenType == ScreenType.desktop ? Insets.small : 0;
    IconButton searchButton = IconButton(
      iconSize: 30,
      hoverColor: Theme.of(context).colorScheme.onPrimary,
      style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              side: BorderSide.none, borderRadius: BorderRadius.zero))),
      onPressed: () {
        String text = _searchController.value.text;
        text = text.trim();
        if (text != "") {
          if (kIsWeb) {
            GoRouter.of(context).go('/s?search=$text');
          } else if (widget.isHome) {
            GoRouter.of(context).push('/s?search=$text');
          } else {
            GoRouter.of(context).go('/s?search=$text');
          }
        }
      },
      icon: const Icon(
        Icons.search_rounded,
      ),
    );
    if (screenType == ScreenType.desktop || screenType == ScreenType.tablet) {
      return Row(
        children: [
          const Expanded(child: SizedBox()),
          Padding(
            padding: EdgeInsets.all(spacing),
            child: SizedBox(
              width: 300,
              height: 30,
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  searchButton.onPressed!();
                },
                controller: _searchController,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                scrollPadding: const EdgeInsets.all(0),
                cursorWidth: 1,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(Insets.xsmall),
                  suffixIconColor: Theme.of(context).colorScheme.primary,
                  suffixIcon: searchButton,
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant,
                  hintText: "Search sayuga.com",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          widget.index == 1
              ? Padding(
                  padding: EdgeInsets.all(spacing),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 3,
                                color: Theme.of(context).colorScheme.primary))),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("About Us"),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(spacing),
                  child: TextButton(
                    onPressed: () {
                      if (kIsWeb) {
                        GoRouter.of(context).go("/about-us");
                      } else {
                        GoRouter.of(context).push("/about-us");
                      }
                    },
                    child: const Text("About US"),
                  ),
                ),
          widget.index == 2
              ? Padding(
                  padding: EdgeInsets.all(spacing),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 3.0,
                                color: Theme.of(context).colorScheme.primary))),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Couture"),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(spacing),
                  child: TextButton(
                    onPressed: () {
                      if (kIsWeb) {
                        context.go("/custom-design");
                      } else {
                        context.push("/custom-design");
                      }
                    },
                    child: const Text("Couture"),
                  ),
                ),
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        height: 30,
        child: TextField(
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            searchButton.onPressed!();
          },
          controller: _searchController,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          scrollPadding: const EdgeInsets.all(0),
          cursorWidth: 1,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(Insets.xsmall),
            suffixIconColor: Theme.of(context).colorScheme.primary,
            suffixIcon: searchButton,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceVariant,
            hintText: "Search sayuga.com",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
