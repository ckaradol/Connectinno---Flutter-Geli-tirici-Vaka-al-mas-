import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../theme.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<AuthBloc>().add(SignInWithGoogle());
      },
      child: Container(
        width: double.maxFinite,
        height: buttonHeight,
        decoration: BoxDecoration(
            color: AppTheme.fillColor(
                context),
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.googleLogo),
            SizedBox(width: defaultPadding/3,),
            Text("connectWithGoogle".tr(),style: TextStyle(color: AppTheme.hintColor(context),fontWeight: FontWeight.w600),),

          ],
        ),
      ),
    );
  }
}
