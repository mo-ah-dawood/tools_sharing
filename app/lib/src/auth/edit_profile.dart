import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:ready_form/ready_form.dart';
import 'package:ready_validation/ready_validation.dart';
import 'package:tools_sharing/src/auth/user.dart';
import 'package:open_location_picker/open_location_picker.dart';
import '../localization/app_localizations.dart';
import '../shared/app_logo.dart';
import '../shared/google_button.dart';
import '../shared/platform_screen.dart';
import 'auth_controller.dart';

class EditProfileScreen extends StatefulWidget {
  final AuthController authController;
  static const routeName = '/EditProfile';
  const EditProfileScreen({super.key, required this.authController});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserModel user;
  @override
  void didChangeDependencies() {
    user = widget.authController.user!;
    widget.authController.addListener(_onChanged);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.authController.removeListener(_onChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OpenMapSettings(
        getCurrentLocation: () async {
          try {
            return _determinePosition(context);
          } catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
            rethrow;
          }
        },
        child: PlatformScreen(
          child: ReadyForm(
            onPostData: () async {
              await widget.authController.updateUserdata(context, user);
              return OnPostDataResult();
            },
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(30),
                children: [
                  const Center(child: AppLogo.horizontal()),
                  const SizedBox(height: 50),
                  TextFormField(
                    onSaved: (newValue) {
                      user = user.copyWith(email: newValue);
                    },
                    initialValue: user.email,
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [
                      AutofillHints.username,
                      AutofillHints.email,
                    ],
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 255,
                    validator: context.string().required().email(),
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).email),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    onSaved: (newValue) {
                      user = user.copyWith(name: newValue);
                    },
                    initialValue: user.name,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    autofillHints: const [AutofillHints.name],
                    validator: context.string().required().hasMinLength(10),
                    maxLength: 100,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).name),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    onSaved: (newValue) {
                      user = user.copyWith(phone: newValue);
                    },
                    initialValue: user.phone,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    validator: context.string().required().validateWith(
                        (value, _) => _validatePhone(value, context)),
                    maxLength: 11,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).phone),
                  ),
                  const SizedBox(height: 15),
                  OpenMapPicker(
                    validator:
                        context.validator<FormattedLocation?>().required(),
                    initialValue: user.address,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).location,
                    ),
                    onSaved: (FormattedLocation? newValue) {
                      user = user.copyWith(address: newValue);
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      if (!widget.authController.linkedToGoogle &&
                          widget.authController.googleEnabled) ...[
                        Expanded(
                          child: GoogleButton(
                            label: AppLocalizations.of(context).linkWithGoogle,
                            onPressed: () =>
                                widget.authController.linkWithGoogle(context),
                          ),
                        ),
                        Expanded(
                          child: Text(AppLocalizations.of(context).or,
                              textAlign: TextAlign.center),
                        ),
                      ],
                      Expanded(
                        child: ProgressButton(
                          child: FittedBox(
                              child: Text(AppLocalizations.of(context).send)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validatePhone(String value, BuildContext context) {
    if (!value.isLocalEgyptianPhone) {
      return AppLocalizations.of(context).mustBeValidPhoneNumber;
    }
    return null;
  }

  Future<LatLng?> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        return Future.error(
            AppLocalizations.of(context).locationServiceDisabled);
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          return Future.error(
              AppLocalizations.of(context).locationPermissionDenied);
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        return Future.error(
            AppLocalizations.of(context).locationPermissionPermanentlyDenied);
      }
    }
    var pos = await Geolocator.getCurrentPosition();
    return LatLng(pos.latitude, pos.longitude);
  }

  void _onChanged() {
    setState(() {});
  }
}

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(EditProfileScreen.routeName);
      },
      child: const Icon(Icons.person_rounded),
    );
  }
}
