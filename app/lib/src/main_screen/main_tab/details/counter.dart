part of 'tool_details.dart';

class _Counter extends StatelessWidget {
  final ToolDetailsController controller;
  const _Counter({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverToBoxAdapter(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller.model.isRented) ...[
                ListTile(
                  textColor: Theme.of(context).colorScheme.error,
                  title: Text(
                    AppLocalizations.of(context).willBeAvalibleAt(
                        controller.model.endDate!.toDate().format24(context)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ] else ...[
                ListTile(
                  title: Text(AppLocalizations.of(context).days),
                ),
                ListTile(
                  trailing: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 16),
                    child: Text(
                      "${controller.orderItem.price.noTrailing()} ${AppLocalizations.of(context).currencyDisplay}",
                      style:
                          Theme.of(context).extension<AppStyles>()!.pricLarge,
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: controller.model.isRented
                            ? null
                            : controller.remove,
                        icon: const Icon(Icons.remove_rounded),
                      ),
                      Text(controller.orderItem.days.toString()),
                      IconButton(
                        onPressed:
                            controller.model.isRented ? null : controller.add,
                        icon: const Icon(Icons.add_rounded),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
