// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

List<BankModel> bankModelFromJson(String str) =>
    List<BankModel>.from(json.decode(str).map((x) => BankModel.fromJson(x)));

String bankModelToJson(List<BankModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankModel {
  dynamic name;
  dynamic slug;
  dynamic code;
  dynamic longCode;
  dynamic country;
  dynamic currency;
  dynamic type;
  dynamic gateway;

  BankModel({
    this.name,
    this.slug,
    this.code,
    this.longCode,
    this.country,
    this.currency,
    this.type,
    this.gateway,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        name: json["name"],
        slug: json["slug"],
        code: json["code"],
        longCode: json["longCode"],
        country: json["country"],
        currency: json["currency"],
        type: json["type"],
        gateway: json["gateway"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "code": code,
        "longCode": longCode,
        "country": country,
        "currency": currency,
        "type": type,
        "gateway": gateway,
      };
}

ValidateBank validateBankFromJson(String str) =>
    ValidateBank.fromJson(json.decode(str));

String validateBankToJson(ValidateBank data) => json.encode(data.toJson());

class ValidateBank {
  bool? requestSuccessful;
  String? responseMessage;
  String? responseCode;
  ResponseBody? responseBody;

  ValidateBank({
    this.requestSuccessful,
    this.responseMessage,
    this.responseCode,
    this.responseBody,
  });

  factory ValidateBank.fromJson(Map<String, dynamic> json) => ValidateBank(
        requestSuccessful: json["requestSuccessful"],
        responseMessage: json["responseMessage"],
        responseCode: json["responseCode"],
        responseBody: json["responseBody"] == null
            ? null
            : ResponseBody.fromJson(json["responseBody"]),
      );

  Map<String, dynamic> toJson() => {
        "requestSuccessful": requestSuccessful,
        "responseMessage": responseMessage,
        "responseCode": responseCode,
        "responseBody": responseBody?.toJson(),
      };
}

class ResponseBody {
  String? accountNumber;
  String? accountName;
  String? bankCode;

  ResponseBody({
    this.accountNumber,
    this.accountName,
    this.bankCode,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) => ResponseBody(
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        bankCode: json["bankCode"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "accountName": accountName,
        "bankCode": bankCode,
      };
}

// To parse this JSON data, do
//
//     final myBankModel = myBankModelFromJson(jsonString);

List<MyBankModel> myBankModelFromJson(String str) => List<MyBankModel>.from(json.decode(str).map((x) => MyBankModel.fromJson(x)));


String myBankModelToJson(MyBankModel data) => json.encode(data.toJson());

class MyBankModel {
  dynamic user;
  dynamic bankName;
  dynamic bankCode;
  dynamic accountHolder;
  dynamic accountNumber;

  MyBankModel({
    this.user,
    this.bankName,
    this.bankCode,
    this.accountHolder,
    this.accountNumber,
  });

  factory MyBankModel.fromJson(Map<String, dynamic> json) => MyBankModel(
        user: json["user"],
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
        accountHolder: json["account_holder"],
        accountNumber: json["account_number"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "bank_name": bankName,
        "bank_code": bankCode,
        "account_holder": accountHolder,
        "account_number": accountNumber,
      };
}
