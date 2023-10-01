import 'package:go_router/go_router.dart';
import 'package:mood_diary/features/authentication/views/login_screen.dart';
import 'package:mood_diary/features/authentication/views/signup_screen.dart';
import 'package:mood_diary/common/widgets/main_navigation.dart';

class Routes {
  static const signupScreen = {
    'name': 'Sign Up',
    'path': '/',
  };
  static const loginScreen = {
    'name': 'Log In',
    'path': '/join',
  };
  static const mainScreen = {
    'name': 'Main',
    'path': '/:tab(home|write)',
  };
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: Routes.signupScreen['name'],
      path: Routes.signupScreen['path']!,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: Routes.loginScreen['name'],
      path: Routes.loginScreen['path']!,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: Routes.mainScreen['name'],
      path: Routes.mainScreen['path']!,
      builder: (context, state) {
        final tab = state.pathParameters['tab']!;
        return MainNavigation(tab: tab);
      },
    ),
  ],
);
