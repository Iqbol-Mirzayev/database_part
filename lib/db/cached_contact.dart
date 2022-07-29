import 'package:flutter/foundation.dart';

const String contactsTable = "cached_contact";

class CachedContactsFields {
  static final List<String> values = [
    /// Add all fields
    id, fullName, phone
  ];
  static const String id = "_id";
  static const String fullName = "full_name";
  static const String phone = "phone";
}

class CachedContact {
  final int? id;
  final String fullName;
  final String phone;

  CachedContact({
    this.id,
    required this.fullName,
    required this.phone,
  });

  //TODO 1 Create toJSon and fromJson, and copyWith ----> Success Done

  static CachedContact fromjson(Map<String, Object?> json) {
    return CachedContact(
        id: json[CachedContactsFields.id] as int?,
        fullName: json[CachedContactsFields.fullName] as String,
        phone: json[CachedContactsFields.phone] as String);
  }

  CachedContact copyWith({int? id, String? fullName, String? phone}) {
    return CachedContact(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
    );
  }

  Map<String, Object?> toJson() {
    return {
      CachedContactsFields.id: id,
      CachedContactsFields.fullName: fullName,
      CachedContactsFields.phone: phone,
    };
  }

  @override
  String toString() => '''
        ID: $id 
        FULL NAME $fullName
        PHONE $phone
      ''';
}
