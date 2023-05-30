import 'package:flutter/material.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:ready_image/ready_image.dart';

import '../../app.dart';
import '../../localization/app_localizations.dart';
import 'tool_item.dart';

class ToolView extends StatelessWidget {
  final VoidCallback? onPressed;
  const ToolView({
    super.key,
    required this.item,
    this.onPressed,
  });

  final Tool item;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          children: [
            TableRow(children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.fill,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Expanded(child: _image()),
                      const SizedBox(height: 10),
                      DayPrice(price: item.dayPrice)
                    ],
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 100),
                child: ListTile(
                  title: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    item.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  isThreeLine: true,
                  dense: true,
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }

  Builder _image() {
    return Builder(
      builder: (context) {
        return ReadyImage(
          // decoration: ShapeDecoration(
          //   shape: context.findAncestorWidgetOfExactType<Material>()!.shape!,
          // ),
          errorPlaceholder: (context, url, error) {
            print(url);
            print(item.image);

            return Text("data");
          },
          path: item.image,
        );
      },
    );
  }
}

class DayPrice extends StatelessWidget {
  final double price;
  const DayPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${price.noTrailing()}${AppLocalizations.of(context).currencyDisplay} / ${AppLocalizations.of(context).day}",
      style: Theme.of(context).extension<AppStyles>()?.price,
    );
  }
}
