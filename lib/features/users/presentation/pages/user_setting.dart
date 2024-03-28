import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_eventy/core/constants/constants.dart';
import 'package:k_eventy/features/users/domain/entities/user.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_state.dart';

class UserSettingsPage extends StatelessWidget {
  UserSettingsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: BlocBuilder<RemoteAuthBloc, RemoteAuthState>(
        builder: (context, state) {
          if (state is RemoteAuthDone && state.user != null) {
            UserEntity? user = state.user;
            // print(user?.username);
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      user != null ? Column(
                        children: [
                          _buildImage(user.imagePath),
                          _buildSetting(user),
                        ],
                      )
                      : const Placeholder()
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildImage(String? userImage) {
    return Image.network(
        userImage ?? 'https://via.placeholder.com/150', // Placeholder image URL
        height: 150,
        width: 150,
    );
  }

  Widget _buildSetting(UserEntity? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Username'),
          subtitle: Text(user?.username ?? "Username"),
          onTap: () {
            // Handle onTap action
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('Email'),
          subtitle: Text(user?.email ?? "Email"),
          onTap: () {
            // Handle onTap action
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('Name'),
          subtitle: Text(user?.name ?? "Name"),
          onTap: () {
            // Handle onTap action
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Change Password'),
          onTap: () {
            // Handle onTap action
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Log Out'),
          onTap: () {
            // Handle onTap action
          },
        ),
      ],
    );
  }
}
