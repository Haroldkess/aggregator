import 'dart:convert';
import 'dart:developer';

import 'package:benji_aggregator/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/agent_withdrawal_model.dart';
import '../model/bank_model.dart';
import '../services/api_url.dart';
import '../services/pref.dart';
import 'error_controller.dart';

class BankController extends GetxController {
  static BankController get instance {
    return Get.find<BankController>();
  }

  RxBool isloadBank = false.obs;
  RxBool isLoadWithdrawal = false.obs;

  RxBool isLoadAdd = false.obs;
  RxBool isLoadSaved = false.obs;
  RxBool isVerifyBank = false.obs;
  RxList<BankModel> bank = <BankModel>[].obs;
  Rx<ValidateBank> myInfo = ValidateBank().obs;
  Rx<MyBankModel> myBank = MyBankModel().obs;
  Rx<AgentwithdrawalModel> agentWithdrawal = AgentwithdrawalModel().obs;
  var subCatSelected = "Select".obs;

  @override
  void onInit() {
    // TODO: implement onInit

    getBanks();
    super.onInit();
  }

  Future getBanks() async {
    isloadBank.value = true;
    late String token;
    //update();
    var url = Api.baseUrl + Api.bankList;
    await KeyStore.getToken().then((element) {
      token = element!;
    });
    log(token);
    try {
      http.Response? response = await RequestData.getApi(url, token);

      var responseData = await ApiProcessorController.errorState(
        response,
      );
      //log(responseData.toString());
      var save = bankModelFromJson(responseData);
      bank.value = save;

      update();
    } catch (e) {
      log("error" + e.toString());
    }
    isloadBank.value = false;
    update();
  }

  Future getAgentWithdrawal() async {
    isLoadWithdrawal.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    //update();
    var url = Api.baseUrl + Api.agentWithdrawal + "?agent_id=$id";
    await KeyStore.getToken().then((element) {
      token = element!;
    });
    consoleLog(token);
    try {
      http.Response? response = await RequestData.getApi(url, token);

      var responseData = await ApiProcessorController.errorState(
        response,
      );
      //log(responseData.toString());
      var save = AgentwithdrawalModel.fromJson(jsonDecode(responseData));
      //  bank.value = save;
      agentWithdrawal.value = save;
      update();
    } catch (e) {
      log("error" + e.toString());
    }
    isLoadWithdrawal.value = false;
    update();
  }

  Future getSavedBanks() async {
    isLoadSaved.value = true;
    late String token;
    //update();
    var url = Api.baseUrl + Api.savedBank;
    await KeyStore.getToken().then((element) {
      token = element!;
    });
    log(token);
    try {
      http.Response? response = await RequestData.getApi(url, token);

      var responseData = await ApiProcessorController.errorState(
        response,
      );
      log("test  ");

      //log(responseData.toString());
      var save = myBankModelFromJson(responseData);
      // var save = MyBankModel.fromJson(jsonDecode(responseData));
      log("test  " + save.toString());
      myBank.value = save.first;
      isLoadSaved.value = false;
      update();
    } catch (e) {
      log("error " + e.toString());
    }
    isLoadSaved.value = false;
    update();
  }

  Future validateMyAccount(String num, String code) async {
    isVerifyBank.value = true;
    late String token;
    //update();
    var url =
        Api.baseUrl + Api.validateBank + "?account_number=$num&bank_code=$code";
    await KeyStore.getToken().then((element) {
      token = element!;
    });
    consoleLog(num + code);
    try {
      http.Response? response = await RequestData.getApi(url, token);

      var responseData = await ApiProcessorController.errorState(
        response,
      );
      //log(responseData.toString());
      var save = ValidateBank.fromJson(jsonDecode(responseData));
      myInfo.value = save;
      isVerifyBank.value = false;

      update();
    } catch (e) {
      log("error" + e.toString());
    }
    isVerifyBank.value = false;
    update();
  }

  Future addBank(id, bankName, bankCode, acccountName, accountNumber) async {
    isLoadAdd.value = true;
    late String token;
    update();
    var url = Api.baseUrl + Api.addBank;
    // print(id.toString() +
    //     bankName.toString() +
    //     bankCode.toString() +
    //     acccountName.toString() +
    //     accountNumber.toString());
    Map finalData = {
      "user": "${id.toString()}",
      "bank_name": "${bankName.toString()}",
      "bank_code": "${bankCode.toString()}",
      "account_holder": "${acccountName.toString()}",
      "account_number": "${accountNumber.toString()}",
    };
    await KeyStore.getToken().then((element) {
      token = element!;
    });

    try {
      http.Response? response =
          await RequestData.postApi(url, token, finalData);
      var responseData = await ApiProcessorController.errorState(
        response,
      );
      var jsonData = jsonDecode(response!.body);
      if (responseData != null) {
        getSavedBanks();
        ApiProcessorController.successSnack("Added successfully");
        Get.back();
      }
    } catch (e) {
      consoleLog(e.toString());
    }

    isLoadAdd.value = false;
    update();
  }

  Future addSubCat(String val) async {
    subCatSelected.value = val;
    update();
  }
}
