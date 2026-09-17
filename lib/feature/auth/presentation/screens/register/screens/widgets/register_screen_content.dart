import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:flutter/material.dart';

class RegisterScreenContent extends StatelessWidget {
  const RegisterScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Register"),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.login);
            },
            icon: Icon(Icons.eighteen_mp),
          ),
        ],
      ),
    );
  }
}
