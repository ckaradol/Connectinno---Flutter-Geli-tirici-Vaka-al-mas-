import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/blocs/auth_bloc/auth_bloc.dart';
import 'package:noteapp/widgets/app_text_form_field.dart';

import '../../../theme.dart';
import '../../../widgets/app_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor(context),
      appBar: AppBar(backgroundColor: AppTheme.backgroundColor(context)),
      body: Padding(
        padding: EdgeInsets.all(appPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "forgotPasswordTitle".tr(),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: AppTheme.titleTextColor(context)),
                ),
                SizedBox(height: defaultPadding),
                Text(
                  "pleasePhoneNumber".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppTheme.hintColor(context), fontSize: 15),
                ),
                SizedBox(height: defaultPadding),
                AppTextFormField(controller: email, hintText: "email".tr(), textType: TextInputType.emailAddress),
              ],
            ),
            Column(
              children: [
                AppButton(
                  title: "send".tr(),
                  onTap: () {
                    context.read<AuthBloc>().add(ForgotPassword(mail: email.text));
                  },
                ),
                SizedBox(height: defaultPadding),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
