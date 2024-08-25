import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/auth/auth.dart';
import 'package:shamo_mobile/features/home/home.dart';

part 'sections/form_section.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    context.read<FormAuthBloc>().add(InitialFormAuthEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(Dimens.dp16),
        children: [
          Dimens.dp24.height,
          const HeadingText('Login'),
          const RegularText('Sign In to Countinue'),
          _FormSection(key: widget.key),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimens.dp16),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Don\'t have an account?',
            style: context.theme.textTheme.bodyMedium,
            children: <TextSpan>[
              TextSpan(
                text: ' Sign up',
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.theme.primaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RegisterPage.routeName);
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
