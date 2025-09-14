import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../blocs/obsecure_text/obsecure_text_cubit.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/google_button.dart';
import '../../../views/register_screen/register.dart';
import '../../forgot_password_screen/screen/forgot_password_screen.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor(context),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) =>
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: appPadding),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppAssets.logo),
                        SizedBox(height: defaultPadding * 2),
                        AppTextFormField(hintText: "emailOrPhone".tr()),
                        SizedBox(height: defaultPadding / 2),
                        BlocProvider(
                          create: (_) => ObscureTextCubit(),
                          child: BlocBuilder<ObscureTextCubit, bool>(
                            builder: (context, isObscured) {
                              return AppTextFormField(
                                obsecureText: isObscured,
                                hintText: "password".tr(),
                                suffixIcon: IconButton(onPressed: () {
                                  context.read<ObscureTextCubit>().toggle();
                                }, icon: isObscured ? SvgPicture.asset(AppAssets.visibleOff) : SvgPicture.asset(AppAssets.visible, width: 24, height: 24,)),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: defaultPadding / 1.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppTheme.primaryColor(context)), padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
                              onPressed: () {
                                NavigationService.push(ForgotPasswordScreen());
                              },
                              child: Text("forgotPassword".tr()),
                            ),
                          ],
                        ),
                        SizedBox(height: defaultPadding * 1.5),
                        AppButton(title: "signIn".tr(),),
                        SizedBox(height: defaultPadding),
                        GoogleButton(),
                        SizedBox(height: defaultPadding * 2),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text("dontAccount".tr(), style: TextStyle(color: AppTheme.hintColor(context))),
                            TextButton(
                              style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppTheme.primaryColor(context)), padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
                              onPressed: () {
                                NavigationService.push(RegisterScreen());
                              },
                              child: Text("signUp".tr()),
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
