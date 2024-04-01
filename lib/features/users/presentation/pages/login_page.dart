import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_eventy/config/route/navigation_bottom.dart';
import 'package:k_eventy/features/event/presentation/widgets/common/my_button.dart';
import 'package:k_eventy/features/event/presentation/widgets/common/my_textfield.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_event.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:k_eventy/features/users/presentation/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn(BuildContext context) {
    BlocProvider.of<RemoteAuthBloc>(context).add(LoginEvents(
      usernameController.text,
      passwordController.text,
    ));
  }

  void navigateToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: BlocListener<RemoteAuthBloc, RemoteAuthState>(
            listener: (context, state) {
              if (state is RemoteAuthDone) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const NavigationBottom()),
                );
              }

              if (state is RemoteAuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.exception.toString()}'),
                  ),
                );
              }
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),

                      // logo
                      const Icon(
                        Icons.android,
                        size: 100,
                      ),

                      const SizedBox(height: 50),

                      // welcome back, you've been missed!
                      Text(
                        'Welcome back you\'ve been missed!',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // username text field
                      MyTextField(
                        controller: usernameController,
                        hintText: 'Username',
                        obscureText: false,
                      ),

                      const SizedBox(height: 10),

                      // password text field
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),

                      const SizedBox(height: 25),

                      // sign in button
                      MyButton(
                        onTap: () => signUserIn(context),
                        text: 'Sign in',
                      ),

                      const SizedBox(height: 25),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),
                      // not a member? register now
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => navigateToRegisterPage(context),
                            child: const Text(
                              'Register now',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                BlocBuilder<RemoteAuthBloc, RemoteAuthState>(
                  builder: (context, state) {
                    if (state is RemoteAuthLoading) {
                      return Container(
                        color: Colors.black.withOpacity(0.2),
                        child: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
