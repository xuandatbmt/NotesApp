// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.uid,
    this.email,
    this.emailVerified,
    this.displayName,
    this.disabled,
    this.metadata,
    this.passwordHash,
    this.tokensValidAfterTime,
    this.providerData,
  });

  String uid;
  String email;
  bool emailVerified;
  String displayName;
  bool disabled;
  Metadata metadata;
  String passwordHash;
  String tokensValidAfterTime;
  List<ProviderDatum> providerData;
  factory ProfileModel.fromModel(ProfileModel model) =>
      ProfileModel(email: model.displayName, displayName: model.email);
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        uid: json["uid"],
        email: json["email"],
        emailVerified: json["emailVerified"],
        displayName: json["displayName"],
        disabled: json["disabled"],
        metadata: Metadata.fromJson(json["metadata"]),
        passwordHash: json["passwordHash"],
        tokensValidAfterTime: json["tokensValidAfterTime"],
        providerData: List<ProviderDatum>.from(
            json["providerData"].map((x) => ProviderDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "emailVerified": emailVerified,
        "displayName": displayName,
        "disabled": disabled,
        "metadata": metadata.toJson(),
        "passwordHash": passwordHash,
        "tokensValidAfterTime": tokensValidAfterTime,
        "providerData": List<dynamic>.from(providerData.map((x) => x.toJson())),
      };
}

class Metadata {
  Metadata({
    this.lastSignInTime,
    this.creationTime,
  });

  String lastSignInTime;
  String creationTime;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        lastSignInTime: json["lastSignInTime"],
        creationTime: json["creationTime"],
      );

  Map<String, dynamic> toJson() => {
        "lastSignInTime": lastSignInTime,
        "creationTime": creationTime,
      };
}

class ProviderDatum {
  ProviderDatum({
    this.uid,
    this.displayName,
    this.email,
    this.providerId,
  });

  String uid;
  String displayName;
  String email;
  String providerId;

  factory ProviderDatum.fromJson(Map<String, dynamic> json) => ProviderDatum(
        uid: json["uid"],
        displayName: json["displayName"],
        email: json["email"],
        providerId: json["providerId"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "displayName": displayName,
        "email": email,
        "providerId": providerId,
      };
}
