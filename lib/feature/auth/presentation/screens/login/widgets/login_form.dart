import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/function/validators.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/core/utils/widgets/custom_alert_dialoge.dart';
import 'package:daleeli/core/utils/widgets/custom_elevated_button.dart';
import 'package:daleeli/core/utils/widgets/custom_text_form_field.dart';
import 'package:daleeli/feature/auth/presentation/screens/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<  LoginCubit, LoginState>(
          listener: (context, state) {
        if (state is LoginSuccess) {
                    Navigator.pushReplacementNamed(context, RoutesName.home);

        } else if (state is LogInFailure) {
          showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
              title: 'Login Failed',
              message: state.errorMessage,
              buttonText: 'Try Again',
              isError: true,
              onButtonPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomFormField(
                hint: 'Enter your email',
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.emailValidator,
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 16),
              CustomFormField(
                hint: 'Enter your password',
                label: 'Password',
                controller: _passwordController,
                obscure: _isPasswordObscured,
                validator: Validators.passwordValidator,
                icon: Icons.lock_outline,
                suffixIcon: _isPasswordObscured
                    ? Icons.visibility_off
                    : Icons.visibility,
                onPressed: () {
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                },
              ),
              const SizedBox(height: 30),
              state is LoginLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomElevatedButton(
                      text: 'Login',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginCubit>().login(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                        }
                      },
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppStyle.text14.copyWith(color: AppColors.charcoal),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.register);
                    },
                    child: Text(
                      'Register',
                      style: AppStyle.text14.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
