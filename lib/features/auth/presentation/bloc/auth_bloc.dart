import 'dart:async';

import 'package:badge_test_1/features/auth/domain/entities/person.dart';
import 'package:badge_test_1/utils/const.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/strings.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthInitial());
      if (event is AuthLogin) {
        emit(AuthLoading());
        if (event.name == Const.adminName &&
            event.password == Const.adminPassword) {
          emit(AuthSuccess(Person(name: event.name, password: event.password)));
          return;
        }
        var result = authRepository
            .isPersonFromDB(Person(name: event.name, password: event.password));
        result.fold((l) => emit(AuthFail(Strings.errorInParseDB)), (r) {
          if (r)
            emit(AuthSuccess(
                Person(name: event.name, password: event.password)));
          else
            emit(AuthFail(Strings.userNameNotFound));
        });
      } else if (event is AuthSingeUp) {
        emit(AuthLoading());
        if (event.name == Const.adminName ) {
          emit(AuthFail(Strings.userNameIsNotAllowed));
          return;
        }
        var result = authRepository
            .savePersonInDB(Person(name: event.name, password: event.password));
        result.fold((l) => emit(AuthFail(Strings.errorInParseDB)), (r) {
          if (r)
            emit(AuthSuccess(
                Person(name: event.name, password: event.password)));
          else
            emit(AuthFail(Strings.duplicateUserName));
        });
      }
    });
  }
}
