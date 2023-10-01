import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_diary/common/widgets/button.dart';
import 'package:mood_diary/routes.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onLogInTap() {
    context.pushNamed(Routes.loginScreen['name']!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('🔥 MOOD 🔥'),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Join!',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(36),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(36),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hintText: 'Email'),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(36),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(36),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hintText: 'Password'),
                ),
                SizedBox(height: 20),
                Button(text: 'Create Account')
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: GestureDetector(
          onTap: _onLogInTap,
          child: const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Button(
                    text: 'Log in >',
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
