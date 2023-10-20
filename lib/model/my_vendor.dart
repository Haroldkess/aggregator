import 'dart:convert';

List<MyVendorModel> myVendorModelFromJson(String str) =>
    List<MyVendorModel>.from(
        json.decode(str).map((x) => MyVendorModel.fromJson(x)));

String myVendorModelToJson(List<MyVendorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyVendorModel {
  Agent? agent;
  Vendor? vendor;
  MyVendorModel({
    this.agent,
    this.vendor,
  });
  factory MyVendorModel.fromJson(Map<String, dynamic> json) => MyVendorModel(
        agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
      );

  Map<String, dynamic> toJson() => {
        "agent": agent?.toJson(),
        "vendor": vendor?.toJson(),
      };
}
class Agent {
    int? id;
    String? email;
    String? phone;
    bool? isActiveCustomUserverified;
    String? username;
    String? code;
    bool? isOnline;
    bool? isPassRequest;
    DateTime? created;
    String? firstName;
    String? lastName;
    String? address;
    DateTime? dob;
    String? gender;
    String? religion;
    String? worshipHours;
    String? nationality;
    String? stateOfOrigin;
    String? lga;
    String? permanentAddress;
    String? residentialAddress;
    String? nearestBusStop;
    String? maritalStatus;
    String? nameOfSpouse;
    String? phoneNumberOfSpouse;
    String? license;
    String? image;

    Agent({
        this.id,
        this.email,
        this.phone,
        this.isActiveCustomUserverified,
        this.username,
        this.code,
        this.isOnline,
        this.isPassRequest,
        this.created,
        this.firstName,
        this.lastName,
        this.address,
        this.dob,
        this.gender,
        this.religion,
        this.worshipHours,
        this.nationality,
        this.stateOfOrigin,
        this.lga,
        this.permanentAddress,
        this.residentialAddress,
        this.nearestBusStop,
        this.maritalStatus,
        this.nameOfSpouse,
        this.phoneNumberOfSpouse,
        this.license,
        this.image,
    });

    factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        isActiveCustomUserverified: json["is_activeCustomUserverified"],
        username: json["username"],
        code: json["code"],
        isOnline: json["is_online"],
        isPassRequest: json["isPassRequest"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        address: json["address"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        gender: json["gender"],
        religion: json["religion"],
        worshipHours: json["worship_hours"],
        nationality: json["nationality"],
        stateOfOrigin: json["stateOfOrigin"],
        lga: json["lga"],
        permanentAddress: json["permanent_address"],
        residentialAddress: json["residential_address"],
        nearestBusStop: json["nearest_bus_stop"],
        maritalStatus: json["marital_status"],
        nameOfSpouse: json["nameOfSpouse"],
        phoneNumberOfSpouse: json["phoneNumberOfSpouse"],
        license: json["license"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "is_activeCustomUserverified": isActiveCustomUserverified,
        "username": username,
        "code": code,
        "is_online": isOnline,
        "isPassRequest": isPassRequest,
        "created": "${created!.year.toString().padLeft(4, '0')}-${created!.month.toString().padLeft(2, '0')}-${created!.day.toString().padLeft(2, '0')}",
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "religion": religion,
        "worship_hours": worshipHours,
        "nationality": nationality,
        "stateOfOrigin": stateOfOrigin,
        "lga": lga,
        "permanent_address": permanentAddress,
        "residential_address": residentialAddress,
        "nearest_bus_stop": nearestBusStop,
        "marital_status": maritalStatus,
        "nameOfSpouse": nameOfSpouse,
        "phoneNumberOfSpouse": phoneNumberOfSpouse,
        "license": license,
        "image": image,
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
    String? address;
    bool? isOnline;
    int? averageRating;
    int? numberOfClientsReactions;
    String? shopName;
    String? shopImage;
    String? profileLogo;
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
        averageRating: json["average_rating"],
        numberOfClientsReactions: json["number_of_clients_reactions"],
        shopName: json["shop_name"],
        shopImage: json["shop_image"],
        profileLogo: json["profileLogo"],
        shopType: json["shop_type"] == null ? null : ShopType.fromJson(json["shop_type"]),
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