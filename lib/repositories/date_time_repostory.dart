import 'package:flutter/material.dart';

class DateTimeRepository {
  Future<DateTime?> selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null) return null;


    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,

    );
  }
}
