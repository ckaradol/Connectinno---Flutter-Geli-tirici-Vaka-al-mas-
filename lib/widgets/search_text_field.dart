import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme.dart';

class SearchTextField extends StatelessWidget {
  final Function(String) onChange;
  final TextEditingController? controller;
  const SearchTextField({
    super.key,  this.controller, required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      controller: controller,
      decoration: InputDecoration(
        fillColor: AppTheme.fillColor(context),
        filled: true,
        hintText: "searching".tr(),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: appPadding, horizontal: appPadding),
          child: SvgPicture.asset(AppAssets.search, width: iconSize, height: iconSize),
        ),
        hintStyle: TextStyle(fontSize: 15, color: AppTheme.hintColor(context)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide.none),
      ),
    );
  }
}
