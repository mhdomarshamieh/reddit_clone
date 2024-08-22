import 'package:flutter/material.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () => signInWithGoogle(context, ref),
      icon: Image.asset(
        Constants.googlePath,
        width: 35,
      ),
      label: const Text(
        'Continue with google',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Pallete.greyColor,
        minimumSize: const Size(
          double.infinity,
          50,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
