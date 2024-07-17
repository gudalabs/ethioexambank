import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/view/components/text/label_text.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? prefixicon;
  final String? hintText;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final bool isSearch;
  final bool isCountryPicker;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool readOnly;
  final bool needRequiredSign;
  final int maxLines;
  final bool animatedLabel;
  final Color fillColor;
  final Color fontColor;
  final bool isRequired;
  final bool hasIcon;
  final bool hastextcolor;
  final double fontSize;
  final bool showErrorText;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.readOnly = false,
    this.fillColor = MyColor.transparentColor,
    this.fontColor = MyColor.colorBlack,
    required this.onChanged,
    this.hintText,
    this.prefixicon,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.fontSize = 10,
    this.isSearch = false,
    this.isCountryPicker = false,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = false,
    this.needRequiredSign = false,
    this.maxLines = 1,
    this.animatedLabel = false,
    this.isRequired = false,
    this.hasIcon = false,
    this.hastextcolor = false,
    this.showErrorText = true,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return widget.needOutlineBorder
        ? widget.animatedLabel
            ? TextFormField(
                maxLines: widget.maxLines,
                readOnly: widget.readOnly,
                style: regularMediumLarge.copyWith(color: widget.hastextcolor == true ? MyColor.colorBlack : MyColor.getTextColor()),
                //textAlign: TextAlign.left,
                cursorColor: MyColor.getTextColor(),
                controller: widget.controller,
                autofocus: false,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isPassword ? obscureText : false,
                decoration: InputDecoration(
                  hintText: widget.hintText != null ? widget.hintText!.tr : '',
                  prefixIcon: widget.hasIcon
                      ? Padding(
                          padding: const EdgeInsets.all(Dimensions.space15),
                          child: SvgPicture.asset(
                            widget.prefixicon ?? "",
                            width: 15,
                          ),
                        )
                      : null,
                  contentPadding: const EdgeInsetsDirectional.only(top: 5, start: 15, end: 15, bottom: 5),
                  labelText: widget.labelText?.tr ?? '',
                  labelStyle: regularLarge.copyWith(color: widget.hastextcolor ? MyColor.textColor : MyColor.getLabelTextColor()),
                  fillColor: widget.fillColor,
                  filled: true,
                  errorStyle: widget.showErrorText == false ? const TextStyle(color: Colors.red, fontSize: 0) : null,
                  border: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldEnableBorder()), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()), borderRadius: BorderRadius.circular(Dimensions.space8)),
                  suffixIcon: widget.isShowSuffixIcon
                      ? widget.isPassword
                          ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                          : widget.isIcon
                              ? IconButton(
                                  onPressed: widget.onSuffixTap,
                                  icon: Icon(
                                    widget.isSearch
                                        ? Icons.search_outlined
                                        : widget.isCountryPicker
                                            ? Icons.arrow_drop_down_outlined
                                            : Icons.camera_alt_outlined,
                                    size: 25,
                                    color: MyColor.getPrimaryColor(),
                                  ),
                                )
                              : null
                      : null,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                onChanged: (text) => widget.onChanged!(text),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelText(text: widget.labelText.toString(), isRequired: widget.isRequired),
                  const SizedBox(height: Dimensions.textToTextSpace),
                  TextFormField(
                    maxLines: widget.maxLines,
                    readOnly: widget.readOnly,
                    style: regularLarge.copyWith(color: widget.hastextcolor == true ? widget.fontColor : MyColor.getTextColor()),
                    //textAlign: TextAlign.left,
                    cursorColor: MyColor.getTextColor(),
                    controller: widget.controller,
                    autofocus: false,
                    textInputAction: widget.inputAction,
                    enabled: widget.isEnable,
                    focusNode: widget.focusNode,
                    validator: widget.validator,
                    keyboardType: widget.textInputType,
                    obscureText: widget.isPassword ? obscureText : false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsetsDirectional.only(top: 5, start: 15, end: 15, bottom: 5),
                      hintText: widget.hintText != null ? widget.hintText!.tr : '',
                      hintStyle: regularMediumLarge.copyWith(color: widget.hastextcolor ? MyColor.textColor : MyColor.getHintTextColor().withOpacity(0.7)),
                      fillColor: MyColor.transparentColor,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldEnableBorder()), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                      suffixIcon: widget.isShowSuffixIcon
                          ? widget.isPassword
                              ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                              : widget.isIcon
                                  ? IconButton(
                                      onPressed: widget.onSuffixTap,
                                      icon: Icon(
                                        widget.isSearch
                                            ? Icons.search_outlined
                                            : widget.isCountryPicker
                                                ? Icons.arrow_drop_down_outlined
                                                : Icons.camera_alt_outlined,
                                        size: 25,
                                        color: MyColor.getPrimaryColor(),
                                      ),
                                    )
                                  : null
                          : null,
                    ),
                    onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                    onChanged: (text) => widget.onChanged!(text),
                  )
                ],
              )
        : TextFormField(
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            style: regularLarge.copyWith(color: widget.hastextcolor ? widget.fontColor : MyColor.getTextColor()),
            //textAlign: TextAlign.left,
            cursorColor: MyColor.getHintTextColor(),
            controller: widget.controller,
            autofocus: false,
            textInputAction: widget.inputAction,
            enabled: widget.isEnable,
            focusNode: widget.focusNode,
            validator: widget.validator,
            keyboardType: widget.textInputType,
            obscureText: widget.isPassword ? obscureText : false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsetsDirectional.only(top: 5, start: 0, end: 0, bottom: 5),
              labelText: widget.labelText?.tr,
              labelStyle: regularLarge.copyWith(color: widget.hastextcolor ? MyColor.textColor : MyColor.getLabelTextColor()),
              fillColor: MyColor.transparentColor,
              filled: true,
              border: UnderlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder())),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldEnableBorder())),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder())),
              suffixIcon: widget.isShowSuffixIcon
                  ? widget.isPassword
                      ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                      : widget.isIcon
                          ? IconButton(
                              onPressed: widget.onSuffixTap,
                              icon: Icon(
                                widget.isSearch
                                    ? Icons.search_outlined
                                    : widget.isCountryPicker
                                        ? Icons.arrow_drop_down_outlined
                                        : Icons.camera_alt_outlined,
                                size: 25,
                                color: MyColor.getPrimaryColor(),
                              ),
                            )
                          : null
                  : null,
            ),
            onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
            onChanged: (text) => widget.onChanged!(text),
          );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
