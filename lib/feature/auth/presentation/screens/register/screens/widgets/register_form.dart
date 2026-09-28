import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/function/validators.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/core/utils/widgets/custom_elevated_button.dart';
import 'package:daleeli/core/utils/widgets/custom_text_form_field.dart';
import 'package:daleeli/feature/auth/data/model/register_request_model.dart';
import 'package:daleeli/feature/auth/presentation/screens/register/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showCustomAlert({
    required String title,
    required String message,
    required bool isSuccess,
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.background,
        title: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle_outline : Icons.error_outline,
              color: isSuccess ? AppColors.greenColor : AppColors.redColor,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: AppStyle.text18.copyWith(
                color: isSuccess ? AppColors.greenColor : AppColors.redColor,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: AppStyle.text14.copyWith(color: AppColors.charcoal),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              if (onPressed != null) onPressed();
            },
            child: Text(
              'OK',
              style: AppStyle.text16.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          _showCustomAlert(
            title: 'Success',
            message: 'Account created successfully!',
            isSuccess: true,
            onPressed: () {
              Navigator.pushReplacementNamed(context, RoutesName.home);
            },
          );
        } else if (state is RegisterFailure) {
          _showCustomAlert(
            title: 'Error',
            message: state.errorMessage,
            isSuccess: false,
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
                hint: 'Enter your name',
                label: 'Name',
                controller: _nameController,
                keyboardType: TextInputType.name,
                validator: Validators.nameValidator,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              CustomFormField(
                hint: 'Confirm your password',
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                obscure: _isConfirmPasswordObscured,
                validator: (value) => Validators.confirmPasswordValidator(
                  value,
                  _passwordController.text,
                ),
                icon: Icons.lock_outline,
                suffixIcon: _isConfirmPasswordObscured
                    ? Icons.visibility_off
                    : Icons.visibility,
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                  });
                },
              ),
              const SizedBox(height: 30),
              CustomElevatedButton(
                isLoading: state is RegisterLoading,
                text: 'Register',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    final requestModel = RegisterRequestModel(
                      name: _nameController.text.trim(),
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    context.read<RegisterCubit>().createAccount(
                      registerRequestedModel: requestModel,
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: AppStyle.text14.copyWith(color: AppColors.charcoal),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Login',
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