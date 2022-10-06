import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fit/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (email) =>
                    EmailValidator.validate(email!) ? null : 'Invalid email',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final isValid = formKey.currentState!.validate();
                  if (!isValid) return;
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailController.text.trim());
                    Utils.showSnackBar(
                        'Password reset link sent to your email');
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  } on FirebaseAuthException catch (e) {
                    Utils.showSnackBar(e.message!);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Send Password Reset Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
