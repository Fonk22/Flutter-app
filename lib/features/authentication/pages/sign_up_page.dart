import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo_deck/core/theme/app_theme.dart';
import 'package:memo_deck/features/authentication/widgets/action_link_footer.dart';
import 'package:memo_deck/features/authentication/widgets/auth_action_button.dart';
import 'package:memo_deck/features/authentication/bloc/auth_cubit.dart';
import 'package:memo_deck/core/service_locator.dart';

import '../data/auth_service.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(authService: serviceLocator<AuthService>()),
      child: Builder(builder: (context) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SignedInState) {
              context.goNamed('HomePage');
            }
            if (state is SignedOutState && state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error!)),
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(title: const Text('MemoDeck')),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.cardShadowColor,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          EmailField(controller: _emailController),
                          PasswordField(
                            controller: _passwordController,
                            validator: _passwordValidator,
                          ),
                          AuthActionButton(
                            onPressed: () async {
                              if(_formKey.currentState!.validate()) {
                                final cubit = context.read<AuthCubit>();
                                await cubit.signUp(_emailController.text,
                                    _passwordController.text);
                              }
                            },
                            text: 'Create account',
                          ),
                          ActionLinkFooter(
                            promptText: "Already have an account? ",
                            actionText: 'Log in',
                            onTap: () {
                              context.pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password field cannot be empty';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must include at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must include at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must include at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must include at least one special character';
    }

    return null;
  }
}
