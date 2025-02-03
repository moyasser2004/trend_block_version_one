import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/features/authentication/bloc/authentication_bloc.dart';
import 'package:trend/features/authentication/bloc/authentication_event.dart';
import 'package:trend/features/authentication/bloc/authentication_state.dart';
import 'package:trend/features/authentication/presentation/widgets/custom_button.dart';
import 'package:trend/features/authentication/presentation/widgets/custom_textfield.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  void _resetPassword(BuildContext context) {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address')),
      );
      return;
    }

    final bloc = BlocProvider.of<AuthenticationBloc>(context);
    bloc.add(ResetPasswordEvent(email: _emailController.text));
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
          } else if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: Center(
          child: SizedBox(
            width: 270.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 200.h),
                        Text(
                          'Reset Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        CustomTextfield(
                          name: 'Email Address',
                          isPassword: false,
                          controller: _emailController,
                        ),
                        SizedBox(height: 30.h),
                        CustomButton(
                          text: 'Send Reset Link',
                          onPressed: () => _resetPassword(context),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                if (!isKeyboardOpen)
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Back to Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (!isKeyboardOpen) SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
