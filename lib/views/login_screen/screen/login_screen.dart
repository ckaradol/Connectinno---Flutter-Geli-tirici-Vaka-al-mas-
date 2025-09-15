import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noteapp/blocs/auth_bloc/auth_bloc.dart';

import '../../../blocs/obsecure_text/obsecure_text_cubit.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/google_button.dart';
import '../../../views/register_screen/register.dart';
import '../../forgot_password_screen/screen/forgot_password_screen.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final TextEditingController controllerEmail=TextEditingController();
  final TextEditingController controllerPassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthState authState=context.read<AuthBloc>().state;
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
                        AppTextFormField(hintText: "email".tr(),controller: controllerEmail,),
                        SizedBox(height: defaultPadding / 2),
                        BlocProvider(
                          create: (_) => ObscureTextCubit(),
                          child: BlocBuilder<ObscureTextCubit, bool>(
                            builder: (context, isObscured) {
                              return AppTextFormField(
                                controller: controllerPassword,
                                minLine: 1,
                                maxLine: 1,
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
                                NavigationService.navigateTo("/forgotPassword");
                              },
                              child: Text("forgotPassword".tr()),
                            ),
                          ],
                        ),
                        SizedBox(height: defaultPadding / 1.5),
                        AppButton(
                          isLoading: authState is AuthLoading,
                          title: "signIn".tr(),onTap: (){
                          context.read<AuthBloc>().add(SignInWithEmailPassword(controllerEmail.text, controllerPassword.text));
                        },),
                        SizedBox(height: defaultPadding),
                        GoogleButton(),
                        SizedBox(height: appPadding),
                        TextButton(
                          style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppTheme.primaryColor(context)), padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
                          onPressed: () {
                            context.read<AuthBloc>().add(SignInWithAnonymous());
                          },
                          child: Text("continueWithoutRegistration".tr()),
                        ),
                        SizedBox(height: appPadding),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text("dontAccount".tr(), style: TextStyle(color: AppTheme.hintColor(context))),
                            TextButton(
                              style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppTheme.primaryColor(context)), padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
                              onPressed: () {
                                NavigationService.navigateTo("/register");
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
