import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryPickerTitle extends StatelessWidget {
  const CountryPickerTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headlineMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        '请选择国家/地区'.tr,
        style: style,
      ),
    );
  }
}

const kBorderRadius = Radius.circular(10);
/// Default search bar input decoration.
var kInputDecoration = InputDecoration(
  hintText: "“国家/地区”、“代码”或“拨号代码”".tr,
  hintStyle: const TextStyle(fontSize: 12),
  suffixIcon: const Icon(Icons.search),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(kBorderRadius),
    borderSide: BorderSide(
      width: 2,
      style: BorderStyle.none,
    ),
  ),
  filled: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  fillColor: Colors.white,
);

var countryPicker = FlCountryCodePicker(
    title: const CountryPickerTitle(),
    searchBarDecoration: kInputDecoration,
);