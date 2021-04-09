import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/cubit/user_cubit.dart';
import 'package:firebase_login/pages/pages.dart';
import 'package:firebase_login/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserCubit(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: Size(360,690),
          allowFontScaling: false,
          builder: () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: SignInPage(),
          ),
        ),
      ),
    );
  }
}