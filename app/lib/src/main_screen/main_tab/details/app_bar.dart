part of 'tool_details.dart';

class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.tool,
  });

  final Tool tool;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height / 5,
      flexibleSpace: ReadyImage(
        innerPadding: MediaQuery.of(context).padding.copyWith(bottom: 0),
        path: tool.image,
      ),
    );
  }
}
