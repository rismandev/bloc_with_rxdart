import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login_cubit.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
];
