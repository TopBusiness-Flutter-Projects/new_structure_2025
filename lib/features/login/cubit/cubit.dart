import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_strucuture/core/remote/service.dart';

import 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginStateInitial());
  ServiceApi api;
}
