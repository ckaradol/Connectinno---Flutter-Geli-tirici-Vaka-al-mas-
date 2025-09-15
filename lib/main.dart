import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/blocs/auth_bloc/auth_bloc.dart';
import 'package:noteapp/services/firebase_auth_repository.dart';
import 'package:noteapp/services/navigation_service.dart';
import 'package:noteapp/theme.dart';
import 'package:noteapp/views/forgot_password_screen/forgot_password.dart';
import 'package:noteapp/views/home_screen/home.dart';
import 'package:noteapp/views/login_screen/login.dart';
import 'package:noteapp/views/register_screen/register.dart';
import 'package:toastification/toastification.dart';

import 'blocs/note_bloc/note_bloc.dart';
import 'firebase_options.dart';
import 'views/splash_screen/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(EasyLocalization(supportedLocales: [Locale('en'), Locale('tr')], path: 'assets/translations', fallbackLocale: Locale('en'), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(authRepository: FirebaseAuthRepository())..add(AppStarted())),
        BlocProvider(create: (context) => NoteBloc()),
      ],
      child: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (lastState,state){
          if(lastState is Authenticated) {
            return false;
          } else {
            return true;
          }
        },
        listener: (context, state) {
          if (state is Authenticated) {
            context.read<NoteBloc>().add(InitRepository(user: state.user.user));
          }
        },
        builder: (context, state) {
          return BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              return ToastificationWrapper(
                child: MaterialApp(
                  navigatorKey: NavigationService.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  title: 'Note App',
                  routes: {
                    "/home": (context) => HomeScreen(),
                    "/login": (context) => LoginScreen(),
                    "/register": (context) => RegisterScreen(),
                    "/forgotPassword": (context) => ForgotPasswordScreen(),
                  },
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primaryColor(context))),
                  home: SplashScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
