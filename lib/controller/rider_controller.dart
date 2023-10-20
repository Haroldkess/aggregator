import 'dart:convert';
import 'dart:developer';
import 'package:benji_aggregator/controller/error_controller.dart';
import 'package:benji_aggregator/controller/order_controller.dart';
import 'package:benji_aggregator/services/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/driver_history_model.dart';
import '../model/rider_list_model.dart';
import '../model/rifer_model.dart';
import '../services/pref.dart';

class RiderController extends GetxController {
  static RiderController get instance {
    return Get.find<RiderController>();
  }

  bool? isFirst;
  RiderController({this.isFirst});

  var isLoad = false.obs;
  var isPaging = false.obs;
  var isLoadAssign = false.obs;
  var riderList = <RiderItem>[].obs;
  var rider = RiderModel().obs;
  var allRider = RiderListModel().obs;
  var historyList = <HistoryItem>[].obs;
  var pageVal = 5.obs;
  @override
  void onInit() {
    runTask();
    // TODO: implement onInit
    super.onInit();
  }

  void addPage(int p) {
    pageVal.value = p;
    update();
  }

  Future runTask([bool? isPaginated, start, end]) async {
    late String token;
    if (isPaginated != true) {
      isLoad.value = true;
    } else {
      isPaging.value = true;
    }

    //update();
    var url =
        Api.baseUrl + Api.riderList + "?start=${start ?? 0}&end=${end ?? 5}";
    await KeyStore.getToken().then((element) {
      token = element!;
    });
    try {
      http.Response? response = await RequestData.getApi(url, token);
      var responseData =
          await ApiProcessorController.errorState(response, isFirst ?? true);
      log(responseData);
      if (responseData == null) {
        return;
      }
      var save = RiderListModel.fromJson(jsonDecode(responseData));
      allRider.value = save;
      if (isPaginated != true) {
        riderList.value = save.items!;
      } else {
        for (RiderItem element in save.items!) {
          var lister = riderList.where((p0) => p0.id == element.id);

          if (lister.isEmpty) {
            riderList.add(element);
          }
        }
        update();
      }

      log("${riderList.length}" "${riderList.first.firstName!.toString()}");
      update();
    } catch (e) {
      consoleLog("$e");
    }
    if (isPaginated != true) {
      isLoad.value = false;
    } else {
      isPaging.value = false;
    }

    update();
  }

  Future riderHistory(id, [String? end]) async {
    isLoad.value = true;
    late String token;
    update();

    var url = Api.baseUrl +
        Api.riderHistory +
        "?rider_id=$id&start=0&end=${end ?? 100}";

    await KeyStore.getToken().then((element) {
      token = element!;
    });
    try {
      http.Response? response = await RequestData.getApi(url, token);
      var responseData = await ApiProcessorController.errorState(response);
      try {
        var save = DriverHistoryModel.fromJson(jsonDecode(responseData));
        historyList.value = save.items!;
      } catch (e) {
        consoleLog("$e");
      }
      // notification.value = save;
      update();
    } catch (e) {}
    isLoad.value = false;
    update();
  }

  Future getSpecificRider(id) async {
    late String token;
    isLoad.value = true;
    update();
    var url = Api.baseUrl + Api.getSpecificRider + id.toString();
    await KeyStore.getToken().then((element) {
      token = element!;
    });
    try {
      http.Response? response = await RequestData.getApi(url, token);
      var responseData = await ApiProcessorController.errorState(response);
      var save = RiderModel.fromJson(responseData);
      rider.value = save;
      update();
    } catch (e) {}
    isLoad.value = false;
    update();
  }

  Future assignRiderTask(agentId, riderId, orderId) async {
    late String token;
    isLoadAssign.value = true;
    update();
    var url = Api.baseUrl +
        Api.assignRiderTask +
        "?agent_id=$agentId&rider_id=$riderId";
    var order = {
      "orders": ["$orderId"]
    };
    consoleLog(order.toString());
    var data = order;
    await KeyStore.getToken().then((element) {
      token = element!;
    });
    try {
      http.Response? response = await RequestData.postApi(url, token, data);
      log(response!.statusCode.toString());
      var responseData = await ApiProcessorController.errorState(response);

      log(responseData);
      if (responseData == null) {
        isLoadAssign.value = false;
      } else {
        OrderController.instance.runTask();
        isLoadAssign.value = false;
        Get.close(3);
      }

      update();
    } catch (e) {}
    isLoadAssign.value = false;
    update();
  }
}
