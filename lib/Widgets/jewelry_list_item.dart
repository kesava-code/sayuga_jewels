import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/data/models/jewlery_list_model.dart';

class JewelryListItem extends StatelessWidget {
  const JewelryListItem({super.key, required this.jewelry});
  final Jewelry jewelry;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (kIsWeb) {
           
            context.push('/jewelry/${jewelry.id.toString()}');
          } else {
            context.push('/jewelry/${jewelry.id.toString()}');
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 7 / 8,
              child: jewelry.mainImage != ''
                  ? Image.network(
                      jewelry.mainImage,
                      fit: BoxFit.cover,
                    )
                  : const ColoredBox(color: Colors.white),
            ),
            const SizedBox(
              height: Insets.small,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                jewelry.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                jewelry.price != "0.00" ? "From \$${jewelry.price}" : "",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
