import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../di/service_locator.dart';
import '../../../domain/models/auth_session.dart';
import '../../../domain/repositories/auth_repository.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class AuthLoginRequested extends AuthEvent {
  final AuthProviderType provider;

  const AuthLoginRequested(this.provider);

  @override
  List<Object?> get props => [provider];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

// Internal event for session changes
class _AuthStateChanged extends AuthEvent {
  final AuthSession? session;

  const _AuthStateChanged(this.session);

  @override
  List<Object?> get props => [session];
}

// --------------------
// States
// --------------------
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoadInProgress extends AuthState {
  const AuthLoadInProgress();
}

class AuthAuthenticated extends AuthState {
  final AuthSession session;

  const AuthAuthenticated(this.session);

  @override
  List<Object?> get props => [session];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// --------------------
// BLoC
// --------------------
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = getIt<AuthRepository>();
  StreamSubscription<AuthSession?>? _sessionSubscription;

  AuthBloc() : super(const AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<_AuthStateChanged>(_onStateChanged);

    // Subscribe to domain session changes
    _sessionSubscription = _authRepository.sessionStream.listen(
      (session) => add(_AuthStateChanged(session)),
    );

    add(const AuthStarted());
  }

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final session = _authRepository.currentSession;
    if (session != null) {
      emit(AuthAuthenticated(session));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadInProgress());
    try {
      await _authRepository.signOut();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onStateChanged(
    _AuthStateChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.session != null) {
      emit(AuthAuthenticated(event.session!));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  @override
  Future<void> close() {
    _sessionSubscription?.cancel();
    return super.close();
  }
}
