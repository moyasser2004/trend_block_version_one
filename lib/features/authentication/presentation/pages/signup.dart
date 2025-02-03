import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/features/authentication/bloc/authentication_bloc.dart';
import 'package:trend/features/authentication/bloc/authentication_event.dart';
import 'package:trend/features/authentication/bloc/authentication_state.dart';
import 'package:trend/features/authentication/presentation/widgets/custom_button.dart';
import 'package:trend/features/authentication/presentation/widgets/custom_textfield.dart';
import 'package:trend/features/notifications/bloc/notification_bloc.dart';
import 'package:trend/features/posts/bloc/Bloc_Current_user/Current%20_user_Bloc.dart';
import 'package:trend/features/posts/bloc/Bloc_Current_user/Current%20_user_event.dart';

import '../../../../shared/core/local/SharedPreferencesDemo.dart';
import '../../../../shared/utiles/routes.dart';


class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _validateAndSignup(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final bloc = BlocProvider.of<AuthenticationBloc>(context);
      bloc.add(
        AuthenticationRegisterEvent(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          passwordConfirm: _confirmPasswordController.text,
        ),
      );

      // Listen to registration states
      bloc.stream.listen((state) async {
        if (state is RegistrationLoading) {
          // Show loading dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is RegistrationSuccess) {
          Navigator.of(context).pop(); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          int c = await SharedPreferencesDemo.getID();
          BlocProvider.of<CurrentUserBloc>(context)
              .add(GetPostForCurrentUserEvent(id: c));
          BlocProvider.of<NotificationBloc>(context)
              .add(FetchNotificationsEvent());
          Navigator.pushReplacementNamed(
              context, AppRoutes.home); // Navigate back to login
        } else if (state is RegistrationError) {
          Navigator.of(context).pop(); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: ${state.message}')),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 270.w,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 100.h),
                        Text(
                          'Create Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          'Pick a username for your account. You can always change it later.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomTextfield(
                          name: 'Username',
                          isPassword: false,
                          controller: _usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomTextfield(
                          name: 'Email Address',
                          isPassword: false,
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomTextfield(
                          name: 'Password',
                          isPassword: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomTextfield(
                          name: 'Confirm Password',
                          isPassword: true,
                          controller: _confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.h),
                        CustomButton(
                          text: 'Sign Up',
                          onPressed: () => _validateAndSignup(context),
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
