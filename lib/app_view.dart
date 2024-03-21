import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pc_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pc_app/screens/home/blocs/bloc/get_pizza_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';

import 'screens/auth/view/welcome_screen.dart';
import 'screens/home/view/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Pizza Delivery",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.light(
                background: Colors.grey.shade100,
                onBackground: Colors.black,
                primary: Colors.blue,
                onPrimary: Colors.white)),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => SignInBloc(
                        context.read<AuthenticationBloc>().userRepository),
                  ),
                  BlocProvider(
                    create: (context) => GetPizzaBloc(
                      FirebasePizzaRepo()
                    )..add(GetPizza()),
                  ),
                ],
                child: const HomeScreen(),
              );
            } else {
              return const WelcomeScreen();
            }
          }),
        ));
  }
}
