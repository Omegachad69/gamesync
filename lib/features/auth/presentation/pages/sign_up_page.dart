import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/common/widgets/loader.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/show_snackbar.dart';
import 'package:gameync/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:gameync/features/auth/presentation/pages/login_page.dart';
import 'package:gameync/features/auth/presentation/widgets/auth_field.dart';
import 'package:gameync/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    userNameController.dispose();
    phoneController.dispose();
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
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(149, 0, 0, 0), BlendMode.darken)),
          ),
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0).copyWith(bottom: 16),
            child: SingleChildScrollView(
              child: FrostedGlassBox(
                theWidth: 390,
                theHeight: 800,
                theChild: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        return showSnackBar(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Loader();
                      }
                      return Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 92,
                            ),
                            Text('Get Started !',
                                style: AppStyles.heading40Bold()),
                            const SizedBox(
                              height: 20,
                            ),
                            AuthField(
                                hinText: 'Name', controller: nameController),
                            const SizedBox(
                              height: 20,
                            ),
                            AuthField(
                                hinText: 'WhatsApp No.',
                                controller: phoneController),
                            const SizedBox(
                              height: 30,
                            ),
                            AuthField(
                                hinText: 'E-mail', controller: emailController),
                            const SizedBox(
                              height: 20,
                            ),
                            AuthField(
                                hinText: 'Username',
                                controller: userNameController),
                            const SizedBox(
                              height: 30,
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
                                buttonText: 'SignUp',
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                          AuthSignUp(
                                              uname: userNameController.text
                                                  .trim(),
                                              name: nameController.text.trim(),
                                              phoneNumber:
                                                  phoneController.text.trim(),
                                              email:
                                                  emailController.text.trim(),
                                              password: passwordController.text
                                                  .trim()),
                                        );
                                  }
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.push(context, LoginPage.route()),
                              child: RichText(
                                  text: TextSpan(
                                      text: 'Already have an account ?  ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      children: [
                                    TextSpan(
                                      text: 'Login',
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
                      );
                    },
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
