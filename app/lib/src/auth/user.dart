// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:open_location_picker/open_location_picker.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final bool emailVerified;
  final FormattedLocation? address;
  final List<String> providers;

  UserModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.photo = '',
    this.emailVerified = false,
    this.address,
    this.providers = const [],
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photo,
    bool? emailVerified,
    FormattedLocation? address,
    List<String>? providers,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      emailVerified: emailVerified ?? this.emailVerified,
      address: address ?? this.address,
      providers: providers ?? this.providers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'emailVerified': emailVerified,
      'address': address?.toJson()?..removeWhere((k, v) => k == 'geojson'),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      phone: map['phone'] ?? "",
      photo: map['photo'] ?? "",
      emailVerified: map['emailVerified'] == true,
      address: map['address'] != null
          ? FormattedLocation.fromJson(map['address'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, photo: $photo, emailVerified: $emailVerified, address: $address)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.photo == photo &&
        other.emailVerified == emailVerified &&
        other.address == address &&
        listEquals(other.providers, providers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        photo.hashCode ^
        emailVerified.hashCode ^
        address.hashCode ^
        providers.hashCode;
  }
}

extension UserExt on User {
  UserModel toUserModel() {
    return UserModel(
        id: uid,
        name: displayName ?? "",
        email: email ?? "",
        phone: phoneNumber ?? "",
        photo: photoURL ?? "",
        emailVerified: emailVerified,
        providers: providerData.map((e) => e.providerId).toList());
  }
}
