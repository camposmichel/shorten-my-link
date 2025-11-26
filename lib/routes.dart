import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorten_my_link/pages/about/about_page.dart';
import 'package:shorten_my_link/pages/home/cubit/home_cubit.dart';
import 'package:shorten_my_link/pages/home/home_page.dart';

sealed class MyRouter {
  static const String home = '/';
  static const String about = '/about';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) =>
        BlocProvider(create: (context) => HomeCubit(), child: const HomePage()),
    about: (context) => const AboutPage(),
  };

  static void go(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
