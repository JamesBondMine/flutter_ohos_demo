import 'package:flutter/services.dart';

final positiveNumberFormatter =
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));
final positiveIntegerFieldFormatter =
    FilteringTextInputFormatter.allow(RegExp(r'^[1-9]\d*'));
