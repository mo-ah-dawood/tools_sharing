import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tools_sharing/src/auth/user.dart';
import 'package:tools_sharing/src/localization/app_localizations.dart';

import '../main_screen/main_screen.dart';
import 'auth_service.dart';
import 'confirm_email_view.dart';
import 'login_view.dart';
import 'reset_password_view.dart';

class AuthController with ChangeNotifier, WidgetsBindingObserver {
  final AuthService _authService;
  AuthController(this._authService);

  UserModel? _user;
  UserModel? get user => _user;
  StreamSubscription? _listner;
  StreamSubscription? _listner2;
  bool get authenticated => _user != null;
  bool get emailVerified => _user?.emailVerified == true;
  bool get linkedToGoogle => _user?.providers.contains('google.com') == true;
  bool get googleEnabled {
    if (kIsWeb) return true;
    if (defaultTargetPlatform == TargetPlatform.android) return true;
    if (defaultTargetPlatform == TargetPlatform.iOS) return true;
    return false;
  }

  void loadUser() async {
    _listner = _authService.userChanges().listen(_onUserChanged);
  }

  Future refresh() {
    return _handle(null, _authService.reloadUser());
  }

  _lisntenUser(User? event) {
    _listner2?.cancel();
    _user = event?.toUserModel();
    notifyListeners();
    _listner2 = FirebaseFirestore.instance
        .collection(AuthService.collection)
        .doc(_user!.id)
        .snapshots()
        .listen(_onRemoteUserChanged);
  }

  void _onRemoteUserChanged(DocumentSnapshot<Map<String, dynamic>> event) {
    _user = UserModel.fromMap({...event.data() ?? {}, 'id': event.id});
    notifyListeners();
  }

  void _onUserChanged(User? event) {
    if (event == null) {
      _user = null;
      _listner2?.cancel();
      notifyListeners();
    } else if (_user?.id != event.uid) {
      _lisntenUser(event);
    } else {
      var user = event.toUserModel();
      FirebaseFirestore.instance
          .collection(AuthService.collection)
          .doc(_user!.id)
          .update(_user!
              .copyWith(
                providers: user.providers,
                phone: user.phone.isEmpty ? null : user.phone,
                email: user.email.isEmpty ? null : user.email,
                emailVerified: user.emailVerified,
              )
              .toMap());
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      _authService.reloadUser();
    }
  }

  Future<T> _handle<T>(BuildContext? context, Future<T> action) async {
    try {
      return await action;
    } on FirebaseAuthException catch (e) {
      if (context != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message ?? "")));
      }
      rethrow;
    }
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    var res = await _handle(context, _authService.login(email, password));
    if (!res.emailVerified && context.mounted) {
      Navigator.of(context).pushReplacementNamed(ConfirmEmailView.routeName);
    } else if (res.emailVerified && context.mounted) {
      Navigator.of(context).pushReplacementNamed(MainScreenView.routeName);
    }
  }

  Future<void> updateUserdata(BuildContext context, UserModel user) async {
    await _handle(context, _authService.updateUserData(user, this.user!));
    if (context.mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).dataUpdated)));
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    var res = await _handle(context, _authService.loginWithGoogle());
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      if (!res.emailVerified && context.mounted) {
        Navigator.of(context).pushReplacementNamed(ConfirmEmailView.routeName);
      } else if (res.emailVerified && context.mounted) {
        Navigator.of(context).pushReplacementNamed(MainScreenView.routeName);
      }
    });
  }

  Future<void> linkWithGoogle(BuildContext context) async {
    await _handle(context, _authService.linkWithGoogle());
    var current = _authService.currentUser!;
    FirebaseFirestore.instance
        .collection(AuthService.collection)
        .doc(_user!.id)
        .update(current.withProvider(_user!).toMap());
  }

  Future<void> register(
      BuildContext context, String email, String password, String name) async {
    await _handle(context, _authService.register(email, name, password));
    if (context.mounted) {
      Navigator.of(context).pushNamed(ConfirmEmailView.routeName);
    }
  }

  Future sendVerificationCode(BuildContext context) async {
    await _handle(context, _authService.sendVerificationCode());
  }

  Future sendForgotPasswordCode(BuildContext context, String email) async {
    await _handle(context, _authService.sendForgotPasswordCode(email));
    if (context.mounted) {
      Navigator.of(context)
          .pushNamed(ResetPasswordView.routeName, arguments: email);
    }
  }

  Future<void> resetPassword(
      BuildContext context, String email, String code, String password) async {
    await _handle(context, _authService.resetPassword(email, code, password));
    if (context.mounted) {
      Navigator.of(context)
          .popUntil((route) => route.settings.name == LoginView.routeName);
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _handle(context, _authService.signOut());
  }

  @override
  void dispose() {
    _listner?.cancel();
    _listner2?.cancel();
    super.dispose();
  }
}
