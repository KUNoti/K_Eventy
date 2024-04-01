import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k_eventy/features/event/presentation/widgets/common/my_button.dart';
import 'package:k_eventy/features/event/presentation/widgets/common/my_textfield.dart';
import 'package:k_eventy/features/users/data/data_sources/remote/user_service.dart';
import 'package:k_eventy/features/users/data/models/user.dart';
import 'package:k_eventy/features/users/domain/entities/user.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_event.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:k_eventy/features/users/presentation/pages/login_page.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  File? _image;
  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();

  // final repo = sl<UserRepositoryImpl>();
  UserService userService = UserService(Dio());

  void register() async {
    // Get input values
    BlocProvider.of<RemoteAuthBloc>(context).add( RegisterEvent(
      UserModel(
        username: usernameController.text,
        password: passwordController.text,
        name: nameController.text,
        email: emailController.text,
        imageFile: _image
      )
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: BlocListener<RemoteAuthBloc, RemoteAuthState>(
            listener: (context, state) {
              if (state is RemoteAuthDone) {
                Navigator.pop(context);
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
              children:[
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildImageView(),
                      const SizedBox(height: 25),
                  
                      _buildForm(context),
                  
                      const SizedBox(height: 25),
                  
                      // sign in button
                      MyButton(
                        onTap: () {
                          register();
                        },
                        text: 'Register',
                      ),
                      const SizedBox(height: 25),
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

  Widget _buildImageView() {
    return SizedBox(
      child: _image != null
          ? Image.file(_image!,
        fit: BoxFit.cover,
        height: 200,
        width: 200,
      )
          : Stack(
        children: [
          GestureDetector(
            onTap: () {
              _onImageButtonPressed(ImageSource.gallery, context: context);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black87,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.person,
                size: 150,
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.green,
            ),
          ),
        ],
      )

    );
  }

  Future<void> _onImageButtonPressed(
      ImageSource source, {
        required BuildContext context,
      }) async {
    Map<Permission, PermissionStatus> status = await [
      Permission.camera,
      Permission.storage,
    ].request();

    if (status[Permission.camera] != PermissionStatus.granted ||
        status[Permission.camera] != PermissionStatus.granted) {
      return;
    }

    _pickedFile = await _picker.pickImage(source: source);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
      });
    }
  }

  Widget _buildForm(BuildContext context) {
    return Form(
        child: Column(
          children: [
            MyTextField(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
              },
            ),

            const SizedBox(height: 10),

            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
              },
            ),

            const SizedBox(height: 10),

            MyTextField(
              controller: nameController,
              hintText: 'Name',
              obscureText: false,
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
              },
            ),

            const SizedBox(height: 10),

            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'Please enter a email';
                }
              },
            ),
          ],
        )
    );
  }
}