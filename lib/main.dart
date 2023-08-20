import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'cubits/cubits.dart';
import 'repositories/repositories.dart';
import 'config/app_router.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => DatabaseRepository(),
        ),
        RepositoryProvider(
          create: (context) => StorageRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) =>
                SignupCubit(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc(
              databaseRepository: context.read<DatabaseRepository>(),
              storageRepository: context.read<StorageRepository>(),
            ),
          ),
          BlocProvider(
              create: (context) => SwipeBloc(
                    authBloc: BlocProvider.of<AuthBloc>(context),
                    databaseRepository: context.read<DatabaseRepository>(),
                  )
              //BlocProvider.of<AuthBloc>(context).state.user!.uid),
              ),
          BlocProvider(
            create: (context) => ProfileBloc(
              authBloc: BlocProvider.of<AuthBloc>(context),
              databaseRepository: context.read<DatabaseRepository>(),
            )..add(
                LoadProfile(
                    userId: BlocProvider.of<AuthBloc>(context).state.user!.uid),
              ),
          ),
        ],
        child: const MaterialApp(
          title: 'Dating App',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
