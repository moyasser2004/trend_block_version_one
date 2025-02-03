import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/features/authentication/bloc/authentication_bloc.dart';
import 'package:trend/features/authentication/bloc/authentication_event.dart';
import 'package:trend/features/authentication/bloc/authentication_state.dart';
import 'package:trend/features/authentication/presentation/widgets/custom_button.dart';
import 'package:trend/features/authentication/presentation/widgets/custom_textfield.dart';
import 'package:trend/features/notifications/presentation/Manager/NotificationBloc/notification_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_Current_user/Current%20_user_Bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_Current_user/Current%20_user_event.dart';

import '../../../../shared/core/local/SharedPreferencesDemo.dart';
import '../../../../shared/utiles/routes.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _validateAndLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(
            AuthenticationLoginEvent(
              username: _usernameController.text,
              password: _passwordController.text,
            ),
          );
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
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) async {
          if (state is AuthenticationAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Welcome, ${state.username}!')),
            );
            int c = await SharedPreferencesDemo.getID();
            BlocProvider.of<CurrentUserBloc>(context)
                .add(GetPostForCurrentUserEvent(id: c));
            BlocProvider.of<NotificationBloc>(context)
                .add(FetchNotificationsEvent());
            // Replace the login page with the home page
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login failed: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
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
                            SizedBox(height: 200.h),
                            Text(
                              'T  R  E  N  D',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            CustomTextfield(
                              name: 'Username',
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
                              name: 'Password',
                              controller: _passwordController,
                              isPassword: true,
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
                            SizedBox(height: 30.h),
                            CustomButton(
                              text: 'Login',
                              onPressed: () => _validateAndLogin(context),
                            ),
                            SizedBox(height: 10.h),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.resetPassword);
                                },
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    'assets/icons/google.png',
                                    width: 33.w,
                                    height: 40.h,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    'assets/icons/facebook.png',
                                    width: 38.w,
                                    height: 40.h,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    'assets/icons/tiktok.png',
                                    width: 38.w,
                                    height: 40.h,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    'assets/icons/instagram.png',
                                    width: 42.w,
                                    height: 40.h,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                    if (!isKeyboardOpen)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.signup);
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (!isKeyboardOpen) SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
