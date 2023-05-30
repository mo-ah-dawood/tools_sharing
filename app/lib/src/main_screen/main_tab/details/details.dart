part of 'tool_details.dart';

class _Details extends StatelessWidget {
  const _Details({
    required this.tool,
  });

  final Tool tool;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverToBoxAdapter(
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context).dayPrice),
                subtitle: Text(
                  AppLocalizations.of(context).dayPriceHint,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: DayPrice(price: tool.dayPrice),
              ),
              const Divider(),
              ListTile(
                title: Text(AppLocalizations.of(context).name),
                subtitle: Text(tool.description),
              ),
              if (tool.categoryId.isNotEmpty)
                ListTile(
                  title: Text(AppLocalizations.of(context).category),
                  subtitle: RemoteBuilder(
                    collection: CategoriesService.collection,
                    mapper: Category.fromMap,
                    builder: (Category data) {
                      return Text(data.name);
                    },
                    id: tool.categoryId,
                  ),
                ),
              if (tool.userId.isNotEmpty)
                ListTile(
                  title: Text(AppLocalizations.of(context).addedBy),
                  subtitle: RemoteBuilder(
                    collection: AuthService.collection,
                    mapper: UserModel.fromMap,
                    builder: (UserModel data) {
                      return Text(data.name);
                    },
                    id: tool.userId,
                  ),
                ),
              ListTile(
                title: Text(AppLocalizations.of(context).description),
                subtitle: Text(tool.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
