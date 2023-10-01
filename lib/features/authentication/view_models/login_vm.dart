import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_diary/common/utils.dart';
import 'package:mood_diary/features/authentication/repos/auth_repo.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthRepo _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authProvider);
  }

  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    // final userProfile = ref.read(userProfileProvider.notifier);
    state = await AsyncValue.guard(
      () async {
        await _authRepo.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // await userProfile.createUserProfile(userCredential);
      },
    );
    if (context.mounted) {
      if (state.hasError) {
        showFirebaseErrorSnackBar(context, state.error);
      } else {
        context.go('/home');
      }
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
