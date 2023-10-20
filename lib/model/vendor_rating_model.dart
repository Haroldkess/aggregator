// To parse this JSON data, do
//
//     final ratingModel = ratingModelFromJson(jsonString);

import 'dart:convert';

RatingModel ratingModelFromJson(String str) =>
    RatingModel.fromJson(json.decode(str));

String ratingModelToJson(RatingModel data) => json.encode(data.toJson());

class RatingModel {
  List<RatingItem>? items;
  int? total;
  int? perPage;
  int? start;
  int? end;

  RatingModel({
    this.items,
    this.total,
    this.perPage,
    this.start,
    this.end,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        items: json["items"] == null
            ? []
            : List<RatingItem>.from(
                json["items"]!.map((x) => RatingItem.fromJson(x))),
        total: json["total"],
        perPage: json["per_page"],
        start: json["start"],
        end: json["end"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "total": total,
        "per_page": perPage,
        "start": start,
        "end": end,
      };
}

class RatingItem {
  String? id;
  double? ratingValue;
  String? comment;
  DateTime? created;
  Client? client;
  Vendor? vendor;

  RatingItem({
    this.id,
    this.ratingValue,
    this.comment,
    this.created,
    this.client,
    this.vendor,
  });

  factory RatingItem.fromJson(Map<String, dynamic> json) => RatingItem(
        id: json["id"],
        ratingValue: json["rating_value"],
        comment: json["comment"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating_value": ratingValue,
        "comment": comment,
        "created": created?.toIso8601String(),
        "client": client?.toJson(),
        "vendor": vendor?.toJson(),
      };
}

class Client {
  int? id;
  String? email;
  String? username;
  String? phone;
  String? firstName;
  String? lastName;
  dynamic image;
  String? code;

  Client({
    this.id,
    this.email,
    this.username,
    this.phone,
    this.firstName,
    this.lastName,
    this.image,
    this.code,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "phone": phone,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "code": code,
      };
}

class Vendor {
  int? id;
  String? email;
  String? phone;
  String? username;
  String? code;
  String? firstName;
  String? lastName;
  String? gender;
  dynamic address;
  bool? isOnline;
  double? averageRating;
  dynamic numberOfClientsReactions;
  String? shopName;
  dynamic shopImage;
  dynamic profileLogo;
  ShopType? shopType;

  Vendor({
    this.id,
    this.email,
    this.phone,
    this.username,
    this.code,
    this.firstName,
    this.lastName,
    this.gender,
    this.address,
    this.isOnline,
    this.averageRating,
    this.numberOfClientsReactions,
    this.shopName,
    this.shopImage,
    this.profileLogo,
    this.shopType,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        username: json["username"],
        code: json["code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        address: json["address"],
        isOnline: json["is_online"],
        averageRating: json["average_rating"]?.toDouble(),
        numberOfClientsReactions: json["number_of_clients_reactions"],
        shopName: json["shop_name"],
        shopImage: json["shop_image"],
        profileLogo: json["profileLogo"],
        shopType: json["shop_type"] == null
            ? null
            : ShopType.fromJson(json["shop_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "username": username,
        "code": code,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "address": address,
        "is_online": isOnline,
        "average_rating": averageRating,
        "number_of_clients_reactions": numberOfClientsReactions,
        "shop_name": shopName,
        "shop_image": shopImage,
        "profileLogo": profileLogo,
        "shop_type": shopType?.toJson(),
      };
}

class ShopType {
  String? id;
  String? name;
  String? description;
  bool? isActive;

  ShopType({
    this.id,
    this.name,
    this.description,
    this.isActive,
  });

  factory ShopType.fromJson(Map<String, dynamic> json) => ShopType(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "is_active": isActive,
      };
}
