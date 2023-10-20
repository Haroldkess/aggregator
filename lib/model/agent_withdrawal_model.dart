// To parse this JSON data, do
//
//     final agentwithdrawalModel = agentwithdrawalModelFromJson(jsonString);

import 'dart:convert';

AgentwithdrawalModel agentwithdrawalModelFromJson(String str) =>
    AgentwithdrawalModel.fromJson(json.decode(str));

String agentwithdrawalModelToJson(AgentwithdrawalModel data) =>
    json.encode(data.toJson());

class AgentwithdrawalModel {
  Agent? agent;
  dynamic earnings;

  AgentwithdrawalModel({
    this.agent,
    this.earnings,
  });

  AgentwithdrawalModel copyWith({
    Agent? agent,
    dynamic earnings,
  }) =>
      AgentwithdrawalModel(
        agent: agent ?? this.agent,
        earnings: earnings ?? this.earnings,
      );

  factory AgentwithdrawalModel.fromJson(Map<String, dynamic> json) =>
      AgentwithdrawalModel(
        agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
        earnings: json["earnings"],
      );

  Map<String, dynamic> toJson() => {
        "agent": agent?.toJson(),
        "earnings": earnings,
      };
}

class Agent {
  int? id;
  String? code;
  String? email;
  String? username;
  String? phone;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? address;
  String? plateNumber;
  String? chassisNumber;
  dynamic tripCount;

  Agent({
    this.id,
    this.code,
    this.email,
    this.username,
    this.phone,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.address,
    this.plateNumber,
    this.chassisNumber,
    this.tripCount,
  });

  Agent copyWith({
    int? id,
    String? code,
    String? email,
    String? username,
    String? phone,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
    String? address,
    String? plateNumber,
    String? chassisNumber,
    dynamic tripCount,
  }) =>
      Agent(
        id: id ?? this.id,
        code: code ?? this.code,
        email: email ?? this.email,
        username: username ?? this.username,
        phone: phone ?? this.phone,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        image: image ?? this.image,
        address: address ?? this.address,
        plateNumber: plateNumber ?? this.plateNumber,
        chassisNumber: chassisNumber ?? this.chassisNumber,
        tripCount: tripCount ?? this.tripCount,
      );

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        id: json["id"],
        code: json["code"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        image: json["image"],
        address: json["address"],
        plateNumber: json["plate_number"],
        chassisNumber: json["chassis_number"],
        tripCount: json["tripCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "email": email,
        "username": username,
        "phone": phone,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "image": image,
        "address": address,
        "plate_number": plateNumber,
        "chassis_number": chassisNumber,
        "tripCount": tripCount,
      };
}
