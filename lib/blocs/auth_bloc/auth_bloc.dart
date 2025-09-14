import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:noteapp/views/home_screen/home.dart';
import 'package:noteapp/views/login_screen/login.dart';

import '../../models/app_user.dart';
import '../../repositories/auth_repository.dart';
import '../../services/navigation_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignInWithEmailPassword>(_onSignInWithEmailPassword);
    on<SignUpWithEmailPassword>(_onSignUpWithEmailPassword);
    on<SignOutRequested>(_onSignOutRequested);
    on<SignInWithAnonymous>(_onSignInWithAnonymous);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final user = authRepository.currentUser;
    if (user != null) {
      NavigationService.replaceWith("/home");
      emit(Authenticated(user));
    } else {
      NavigationService.replaceWith("/login");
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignInWithGoogle(SignInWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithGoogle();
      if (user != null) {
        NavigationService.replaceWith("/home");
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignInWithEmailPassword(SignInWithEmailPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithEmailPassword(event.email, event.password);
      if (user != null) {
        NavigationService.replaceWith("/home");
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
 Future<void> _onSignInWithAnonymous(SignInWithAnonymous event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithAnonymous();
      if (user != null) {
        NavigationService.replaceWith("/home");
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignUpWithEmailPassword(SignUpWithEmailPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUpWithEmailPassword(event.email, event.password, displayName: event.displayName);
      if(user!=null) {
        NavigationService.replaceWith("/home");
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }

    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
    emit(Unauthenticated());
  }
}
