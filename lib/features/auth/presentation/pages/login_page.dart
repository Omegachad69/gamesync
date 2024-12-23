import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/common/widgets/loader.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/show_snackbar.dart';
import 'package:gameync/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:gameync/features/auth/presentation/pages/sign_up_page.dart';
import 'package:gameync/features/auth/presentation/widgets/auth_field.dart';
import 'package:gameync/features/auth/presentation/widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/arcane.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0).copyWith(bottom: 16),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  return showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Scaffold(
                    body: Center(child: Loader()),
                  );
                }
                return FrostedGlassBox(
                  theWidth: 390,
                  theHeight: 440,
                  theChild: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 22,
                          ),
                          Text('Login !', style: AppStyles.heading40Bold()),
                          const SizedBox(
                            height: 16,
                          ),
                          AuthField(
                              hinText: 'Email', controller: emailController),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthField(
                            hinText: 'Password',
                            controller: passwordController,
                            isObscureText: true,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          AuthGradientButton(
                              buttonText: 'Login',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(AuthLogin(
                                      email: emailController.text.trim(),
                                      password:
                                          passwordController.text.trim()));
                                }
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, SignUpPage.route());
                            },
                            child: RichText(
                                text: TextSpan(
                                    text: 'Don\'t have an account ?  ',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    children: [
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold),
                                  )
                                ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
