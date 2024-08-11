import 'package:gainz_ai_app/core/common/app/providers/user_provider.dart';
import 'package:gainz_ai_app/core/res/colours.dart';
import 'package:gainz_ai_app/core/res/fonts.dart';
import 'package:gainz_ai_app/core/services/injection_container.dart';
import 'package:gainz_ai_app/core/services/router.dart';
import 'package:gainz_ai_app/firebase_options.dart';
import 'package:gainz_ai_app/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gainz_ai_app/src/home/presentation/cubit/dailyworkout_cubit.dart';
import 'package:gainz_ai_app/src/on_boarding/presentation/views/splashScreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DailyWorkoutCubit>(
          create: (_) => sl<DailyWorkoutCubit>(),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
      ],
      child: MaterialApp(
        title: 'Gainz.Ai App',
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.poppins,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
          ),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colours.primaryColour,
          ),
        ),
        onGenerateRoute: generateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
