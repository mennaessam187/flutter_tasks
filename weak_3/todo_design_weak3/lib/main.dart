import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/features/auth/cubit/logic_cubit/login_cubit.dart';
import 'package:todo_design_weak3/features/home/user_cubit/user_cubit.dart';
import 'package:todo_design_weak3/features/home/view/homeScreen.dart';
import 'package:todo_design_weak3/features/profile/cubit/changePassword_cubit/change_cubit.dart';
import 'package:todo_design_weak3/features/splach/view/StartScreen.dart';
import 'package:todo_design_weak3/features/tasks/cubit/image_cubit/image_cubit.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_cubit.dart';
import 'package:todo_design_weak3/features/tasks/view/addTask.dart';
import 'package:todo_design_weak3/features/profile/view/changePassword.dart';
import 'package:todo_design_weak3/features/tasks/view/editTask.dart';
import 'package:todo_design_weak3/features/auth/view/loginScreen.dart';
import 'package:todo_design_weak3/features/profile/view/profile.dart';
import 'package:todo_design_weak3/features/auth/view/registerScreen.dart';
import 'package:todo_design_weak3/features/splach/view/splachScreen.dart';
import 'package:todo_design_weak3/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangePasswordCubit()),
        BlocProvider(create: (context) => UserCubit()..getUser()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => TaskCubit()..startAllTasksStream()),
        BlocProvider(create: (context) => ImageCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, widget) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(backgroundColor: AppColor.backgroundColor),
            scaffoldBackgroundColor: AppColor.backgroundColor,
            fontFamily: "LexendDeca",
          ),
          home: SplashScreen(),
          routes: {
            "start": (context) => StartScreen(),
            "ragister": (context) => Registerscreen(),
            "login": (context) => Loginscreen(),
            "home": (context) => Homescreen(),
            "addTask": (context) => Addtask(),
            "editTask": (context) => Edittask(),
            "profileScreen": (context) => ProfileScreen(),
            "changePassword": (context) => ChangepasswordScreen(),
          },
        ),
      ),
    );
  }
}
