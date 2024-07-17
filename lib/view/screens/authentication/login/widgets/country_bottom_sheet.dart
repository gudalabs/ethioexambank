import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../core/utils/url_container.dart';
import '../../../../../data/controller/auth/login_controller.dart';
import '../../../../components/image_widget/my_image_widget.dart';

class CountryBottomSheet {
  static void bottomSheet(BuildContext context, LoginController controller) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            if (controller.filteredCountries.isEmpty) {
              controller.filteredCountries = controller.countryList;
            }
            // Function to filter countries based on the search input.
            void filterCountries(String query) {
              if (query.isEmpty) {
                controller.filteredCountries = controller.countryList;
              } else {
                setState(() {
                  controller.filteredCountries = controller.countryList.where((country) => country.country!.toLowerCase().contains(query.toLowerCase())).toList();
                });
                // controller.filteredCountries = controller.filteredCountries.where((country) => country.country!.toLowerCase().contains(query.toLowerCase())).toList();
              }
            }

            return Container(
              height: MediaQuery.of(context).size.height * .8,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: MyColor.getCardBgColor(),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColor.getTextColor().withOpacity(0.2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Add the search field.
                  TextField(
                    controller: controller.searchController,
                    onChanged: filterCountries,
                    decoration:  InputDecoration(
                      hintText: MyStrings.selectACountry.tr,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey), // Set the color for the normal border
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: MyColor.primaryColor), // Set the color for the focused border
                      ),
                    ),
                    cursorColor: MyColor.primaryColor,
                  ),
                  const SizedBox(height: 15),
                  Flexible(
                    child: ListView.builder(
                      itemCount: controller.filteredCountries.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var countryItem = controller.filteredCountries[index];
                        return GestureDetector(
                          onTap: () {
                            controller.selectCountryData(controller.filteredCountries[index]);
                            Navigator.pop(context);

                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: MyColor.transparentColor,
                              border: Border(
                                bottom: BorderSide(
                                  color: MyColor.greyTextColor.withOpacity(0.3),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                  child: MyImageWidget(
                                    imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", countryItem.countryCode.toString().toLowerCase()),
                                    height: Dimensions.space25,
                                    width: Dimensions.space42,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                  child: Text(
                                    '+${countryItem.dialCode}',
                                    style: regularDefault.copyWith(color: MyColor.getTextColor()),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${countryItem.country}',
                                    style: regularDefault.copyWith(color: MyColor.getTextColor()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
