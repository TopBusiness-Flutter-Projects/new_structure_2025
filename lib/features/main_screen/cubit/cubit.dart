import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_strucuture/core/remote/service.dart';

import 'state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.api) : super(MainInitial());

  ServiceApi api;
}
