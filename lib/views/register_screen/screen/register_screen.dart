import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../blocs/obsecure_text/obsecure_text_cubit.dart';
import '../../../repositories/date_time_repostory.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../login_screen/screen/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppTheme.backgroundColor(context)),
      backgroundColor: AppTheme.backgroundColor(context),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: appPadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "signUp".tr(),
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: AppTheme.titleTextColor(context)),
                    ),
                    SizedBox(height: defaultPadding / 2),
                    Text("registerTitle".tr(), style: TextStyle(color: AppTheme.hintColor(context))),
                    SizedBox(height: defaultPadding * 2),
                    AppTextFormField(controller: fullName, hintText: "fullName".tr(), textType: TextInputType.name),
                    SizedBox(height: defaultPadding / 2),
                    AppTextFormField(controller: email, hintText: "email".tr(), textType: TextInputType.emailAddress),
                    SizedBox(height: defaultPadding / 2),

                    BlocProvider(
                      create: (_) => ObscureTextCubit(),
                      child: BlocBuilder<ObscureTextCubit, bool>(
                        builder: (context, isObscured) {
                          return AppTextFormField(
                            controller: password,
                            obsecureText: isObscured,
                            hintText: "password".tr(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<ObscureTextCubit>().toggle();
                              },
                              icon: isObscured ? SvgPicture.asset(AppAssets.visibleOff, width: iconSize, height: iconSize) : SvgPicture.asset(AppAssets.visible, width: iconSize, height: iconSize),
                            ),
                          );
                        },
                      ),
                    ),


                    SizedBox(height: defaultPadding),
                    AppButton(
                      title: "signUp".tr(),
                      onTap: () {
                        String raw = phoneNumber.text;

                        context.read<AuthBloc>().add(SignUpWithEmailPassword(email.text, password.text, fullName.text));
                      },
                    ),
                    SizedBox(height: defaultPadding * 2),

                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text("haveAnAccount".tr(), style: TextStyle(color: AppTheme.hintColor(context))),
                        TextButton(
                          style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppTheme.primaryColor(context)), padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
                          onPressed: () {
                            NavigationService.navigateTo("/login");
                          },
                          child: Text("signIn".tr()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
