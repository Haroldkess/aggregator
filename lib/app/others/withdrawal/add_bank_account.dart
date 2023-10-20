import 'dart:developer';

import 'package:benji_aggregator/controller/bank_controller.dart';
import 'package:benji_aggregator/controller/user_controller.dart';
import 'package:benji_aggregator/src/common_widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../../controller/error_controller.dart';
import '../../../src/common_widgets/my_elevatedButton.dart';
import '../../../src/common_widgets/my_textformfield2.dart';
import '../../../src/providers/constants.dart';
import '../../../src/responsive/reponsive_width.dart';
import '../../../theme/colors.dart';

class AddBankAccountPage extends StatefulWidget {
  const AddBankAccountPage({Key? key}) : super(key: key);

  @override
  State<AddBankAccountPage> createState() => _AddBankAccountPageState();
}

class _AddBankAccountPageState extends State<AddBankAccountPage> {
//===================================== ALL VARIABLES =========================================\\
  FocusNode _bankNames = FocusNode();
  FocusNode _accountNumberFN = FocusNode();
  TextEditingController _accountNumberEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String dropDownItemValue = "Access Bank";

  //================================== FUNCTION ====================================\\

  void dropDownOnChanged(String? onChanged) {
    setState(() {
      dropDownItemValue = onChanged!;
    });
  }

  //=================================== Navigation ============================\\
  void _saveAccount(id, bankName, bankCode, accountName, accountNumber) {
    BankController.instance
        .addBank(id, bankName, bankCode, accountName, accountNumber);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var txt = {
      "dropDown": ["Select"],
    };

    BankController.instance.bank.forEach((element) {
      if (txt["dropDown"]!.contains("${element.name!}|${element.code}")) {
      } else {
        txt["dropDown"]!.add("${element.name!}|${element.code}");
      }
    });
    return ObxValue((validate) {
      return GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: MyAppBar(
            title: "Add bank account",
            elevation: 0.0,
            actions: [],
            backgroundColor: kPrimaryColor,
            toolbarHeight: kToolbarHeight,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: MyResponsiveWidth(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding * 2),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bank Details',
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            height: 1.45,
                          ),
                        ),
                        kSizedBox,
                        kSizedBox,
                        Text(
                          'Bank Name',
                          style: TextStyle(
                            color: kTextGreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kHalfSizedBox,
                        Visibility(
                          visible: validate.value ? validate.value : true,
                          child: GetBuilder(
                              init: BankController(),
                              builder: (cat) {
                                return DropdownButtonFormField<String>(
                                  value:
                                      cat.subCatSelected.value.split("|").first,
                                  onChanged: (value) async {
                                    List<String> selected = txt["dropDown"]!
                                        .where((element) =>
                                            element.split("|").first == value)
                                        .toList();
                                    cat.addSubCat(selected.first.toString());
                                    log(selected.last);
                                  },
                                  enableFeedback: true,
                                  focusNode: _bankNames,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  elevation: 20,
                                  validator: (value) {
                                    if (value == null ||
                                        value.toString() == "Select") {
                                      _accountNumberFN.requestFocus();
                                      return "Enter the account number";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade50),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade50),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade50),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: kErrorBorderColor,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                  ),
                                  iconEnabledColor: kAccentColor,
                                  iconDisabledColor: kGreyColor2,
                                  items: txt["dropDown"]!
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.split("|").first,
                                          //  enabled: true,
                                          child: Row(
                                            children: [
                                              // Image.asset(
                                              //   'assets/icons/accessbank.png',
                                              //   height: 45,
                                              //   width: 45,
                                              // ),
                                              Container(
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7),
                                                child: Text(
                                                  e.split("|").first,
                                                  style: const TextStyle(
                                                    color: kTextBlackColor,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              }),
                        ),
                        SizedBox(
                          height: kDefaultPadding * 2,
                        ),
                        Text(
                          'Account Number',
                          style: TextStyle(
                            color: Color(0xFF575757),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kHalfSizedBox,
                        GetBuilder(
                            init: BankController(),
                            builder: (cat) {
                              return MyTextFormField2(
                                controller: _accountNumberEC,
                                focusNode: _accountNumberFN,
                                hintText: "Enter the account number here",
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                onChanged: (String e) {
                                  if (e.length >= 10) {
                                    BankController.instance.validateMyAccount(
                                        e, cat.subCatSelected.split("|").last);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value!.isEmpty) {
                                    _accountNumberFN.requestFocus();
                                    return "Enter the account number";
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  _accountNumberEC.text = value!;
                                },
                              );
                            }),
                        kSizedBox,
                        ObxValue((
                          info,
                        ) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  validate.value
                                      ? Visibility(
                                          visible: validate.value,
                                          child: CircleAvatar(
                                            radius: 7,
                                            backgroundColor: Colors.transparent,
                                            child: CircularProgressIndicator(
                                              color: kAccentColor,
                                            ),
                                          ))
                                      : Text(
                                          info.value.responseBody != null &&
                                                  _accountNumberEC
                                                      .text.isNotEmpty
                                              ? info.value.responseBody!
                                                      .accountName ??
                                                  'not found'
                                              : "not found",
                                          style: TextStyle(
                                            color: kAccentColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: kDefaultPadding * 4,
                              ),
                              ObxValue((
                                add,
                              ) {
                                return add.value
                                    ? Visibility(
                                        visible: add.value,
                                        child: CircularProgressIndicator(
                                          color: kAccentColor,
                                        ),
                                      )
                                    : MyElevatedButton(
                                        onPressed: info.value.responseBody ==
                                                    null ||
                                                _accountNumberEC.text.isEmpty
                                            ? () => {
                                                  ApiProcessorController.errorSnack("Bank no validated")
                                                }
                                            : () => {
                                                  if (_formKey.currentState!
                                                      .validate())
                                                    {
                                                   
                                                      _saveAccount(
                                                          UserController
                                                              .instance
                                                              .user
                                                              .value
                                                              .id,
                                                          BankController
                                                              .instance
                                                              .subCatSelected
                                                              .split("|")
                                                              .first,
                                                          BankController
                                                              .instance
                                                              .subCatSelected
                                                              .split("|")
                                                              .last,
                                                          info
                                                              .value
                                                              .responseBody!
                                                              .accountName!,
                                                          info
                                                              .value
                                                              .responseBody!
                                                              .accountNumber)
                                                    }
                                                  else
                                                    {print("not valid")}
                                                },
                                        buttonTitle: "Save Account",
                                        circularBorderRadius: 16,
                                        elevation: 10.0,
                                        maximumSizeHeight: 60,
                                        maximumSizeWidth: media.width,
                                        minimumSizeHeight: 60,
                                        minimumSizeWidth: media.width,
                                        titleFontSize: 14,
                                      );
                              }, BankController.instance.isLoadAdd),
                            ],
                          );
                        }, BankController.instance.myInfo),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }, BankController.instance.isVerifyBank);
  }
}
