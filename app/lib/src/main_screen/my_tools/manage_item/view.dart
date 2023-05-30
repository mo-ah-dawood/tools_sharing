import 'package:flutter/material.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:ready_form/ready_form.dart';
import 'package:ready_validation/ready_validation.dart';

import '../../../app.dart';
import '../../../localization/app_localizations.dart';
import '../../../shared/platform_screen.dart';
import '../../categories/controller.dart';
import '../../categories/service.dart';
import '../../tools/tool_item.dart';
import 'controller.dart';
import 'image_picker.dart';
import 'service.dart';

class ManageTool extends StatefulWidget {
  const ManageTool({super.key});

  static const routeName = '/ManageTool';

  @override
  State<ManageTool> createState() => _ManageToolState();
}

class _ManageToolState extends State<ManageTool> with TickerProviderStateMixin {
  final ManageToolController controller =
      ManageToolController(ManageToolService());

  late final CategoriesController categories =
      CategoriesController(CategoriesService(), this);
  late Tool tool;

  @override
  void didChangeDependencies() {
    tool = (ModalRoute.of(context)?.settings.arguments as Tool?) ??
        Tool(
          name: '',
          image: '',
          description: '',
          dayPrice: 0,
          userId: MyApp.auth(context).user!.id,
          categoryId: '',
        );
    categories.listen();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    categories.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformScreen(
        child: ReadyForm(
          onPostData: () async {
            if (tool.id.isEmpty) {
              await controller.add(context, tool);
            } else {
              await controller.update(context, tool);
            }
            return OnPostDataResult();
          },
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(30),
              children: [
                const SafeArea(child: SizedBox()),
                _image(context),
                const SizedBox(height: 50),
                _name(context),
                const SizedBox(height: 15),
                _manufacture(context),
                const SizedBox(height: 15),
                _condition(context),
                const SizedBox(height: 15),
                _price(context),
                const SizedBox(height: 15),
                _description(context),
                const SizedBox(height: 15),
                _category(context),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ProgressButton(
                        child: Text(AppLocalizations.of(context).send),
                      ),
                    ),
                    if (tool.id.isNotEmpty) ...[
                      Expanded(
                        child: Text(AppLocalizations.of(context).or,
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: ProgressButton(
                          onPressed: () => controller.delete(context, tool),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.error),
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.onError),
                          ),
                          child: Text(AppLocalizations.of(context).delete),
                        ),
                      ),
                    ]
                  ],
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: AppLocalizations.of(context).backTo,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const TextSpan(text: " "),
                      WidgetSpan(
                        child: Text(
                          AppLocalizations.of(context).myTools.toLowerCase(),
                        ),
                      )
                    ]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImagePicker _image(BuildContext context) {
    return ImagePicker(
      initialValue: tool.image,
      onSaved: (String? newValue) {
        tool = tool.copyWith(image: newValue);
      },
    );
  }

  TextFormField _description(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) {
        tool = tool.copyWith(description: newValue);
      },
      maxLength: 5000,
      maxLines: 3,
      initialValue: tool.description,
      keyboardType: TextInputType.multiline,
      validator: context.string().required().hasMinLength(10),
      decoration:
          InputDecoration(labelText: AppLocalizations.of(context).description),
    );
  }

  TextFormField _name(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) {
        tool = tool.copyWith(name: newValue);
      },
      textInputAction: TextInputAction.next,
      maxLength: 500,
      initialValue: tool.name,
      validator: context.string().required().hasMinLength(3),
      decoration: InputDecoration(labelText: AppLocalizations.of(context).name),
    );
  }

  TextFormField _manufacture(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) {
        tool = tool.copyWith(manufacture: newValue);
      },
      textInputAction: TextInputAction.next,
      maxLength: 500,
      initialValue: tool.manufacture,
      validator: context.string().required().hasMinLength(3),
      decoration:
          InputDecoration(labelText: AppLocalizations.of(context).manufacture),
    );
  }

  TextFormField _condition(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) {
        tool = tool.copyWith(condition: newValue);
      },
      textInputAction: TextInputAction.next,
      maxLength: 500,
      initialValue: tool.condition,
      validator: context.string().required().hasMinLength(3),
      decoration:
          InputDecoration(labelText: AppLocalizations.of(context).condition),
    );
  }

  TextFormField _price(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) {
        tool = tool.copyWith(dayPrice: double.tryParse(newValue ?? ""));
      },
      maxLength: 8,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      initialValue: tool.dayPrice > 0 ? tool.dayPrice.noTrailing() : "",
      validator: context.string().required().isNumber().greaterThan(0),
      decoration:
          InputDecoration(labelText: AppLocalizations.of(context).dayPrice),
    );
  }

  Widget _category(BuildContext context) {
    return ListenableBuilder(
      listenable: categories,
      builder: (context, _) {
        return DropdownButtonFormField(
          onSaved: (newValue) {
            tool = tool.copyWith(categoryId: newValue);
          },
          value: tool.categoryId.isEmpty ? null : tool.categoryId,
          validator: context.string().required().notEmpty(),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).category,
          ),
          items: categories.list
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                  ))
              .toList(),
          onChanged: (String? value) {},
        );
      },
    );
  }
}
