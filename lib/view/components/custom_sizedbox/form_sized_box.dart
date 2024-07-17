import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';

class FormSizedBox extends StatelessWidget {
  const FormSizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: Dimensions.space20);
  }
}
