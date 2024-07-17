import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/coin_store/deposit/add_new_deposit_controller.dart';
import 'package:quiz_lab/data/repo/coin_store/deposit/deposit_repo.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/components/text-form-field/custom_amount_text_field.dart';
import 'package:quiz_lab/view/components/text-form-field/custom_drop_down_text_field.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../data/model/deposit/deposit_method_response_model.dart';

import '../../../../data/services/api_client.dart';

import 'info_widget.dart';

class NewDepositScreen extends StatefulWidget {
  final String price, id;
  const NewDepositScreen({Key? key, required this.price, required this.id}) : super(key: key);

  @override
  State<NewDepositScreen> createState() => _NewDepositScreenState();
}

class _NewDepositScreenState extends State<NewDepositScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    final controller = Get.put(AddNewDepositController(
      depositRepo: Get.find(),
    ));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getDepositMethod(widget.price);
    });
  }

  @override
  void dispose() {
    Get.find<AddNewDepositController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AddNewDepositController>(
      builder: (controller) => SafeArea(
          child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar:  CustomCategoryAppBar(title: MyStrings.payment.tr),
        body: controller.isLoading
            ? const CustomLoader()
            : SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Container(
 
                  decoration: BoxDecoration(
                    color: MyColor.colorWhite,
                    borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                  ),
                  padding: const EdgeInsets.all(Dimensions.space20),

                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropDownTextField(
                          borderWidth: .5,
                            radius: Dimensions.defaultRadius,
                            labelText: MyStrings.paymentMethod.tr,
                             selectedValue: controller.paymentMethod,
                            onChanged: (newValue) {
                              controller.setPaymentMethod(newValue);
                            },
                            items: controller.methodList.map((Methods bank) {
                              return DropdownMenuItem<Methods>(
                                value: bank,
                                child: Text((bank.name ?? '').tr, style: regularDefault),
                              );
                            }).toList()),
                        const SizedBox(height: Dimensions.space15),
                        CustomAmountTextField(
                          labelText: MyStrings.amount.tr,
                          hintText: MyStrings.enterAmount.tr,
                          inputAction: TextInputAction.done,
                          currency: controller.currency,
                          readOnly: true,
                          controller: controller.amountController,
                          onChanged: (value) {
                            if (value.toString().isEmpty) {
                              controller.changeInfoWidgetValue(0);
                            } else {
                              double amount = double.tryParse(value.toString()) ?? 0;
                              controller.changeInfoWidgetValue(amount);
                            }
                            return;
                          },
                        ),
                        controller.paymentMethod?.name != MyStrings.selectOne ? const InfoWidget() : const SizedBox(),
                        const SizedBox(height: 35),
                        controller.submitLoading
                            ? const RoundedLoadingBtn()
                            : RoundedButton(
                                text: MyStrings.submit.tr,
                                textColor: MyColor.colorWhite,
                                textSize: Dimensions.space17,
                                width: double.infinity,
                                press: () {
                                  controller.submitDeposit(widget.id);
                                },
                              )
                      ],
                    ),
                  ),
                ),
              ),
      )),
    );
  }
}
