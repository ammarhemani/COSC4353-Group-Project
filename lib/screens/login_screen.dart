import 'package:cosc4353_volunteer_app/blocs/login/login_bloc.dart';
import 'package:cosc4353_volunteer_app/screens/home_screen.dart';
import 'package:cosc4353_volunteer_app/services/helper_functions.dart';
import 'package:cosc4353_volunteer_app/widgets/custom_elevated_button.dart';
import 'package:cosc4353_volunteer_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(forceMaterialTransparency: true),
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state is LoginLoaded) {
            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: AbsorbPointer(
              absorbing: state is LoginLoading,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).unfocus(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.blue[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text("VolunteerConnect", textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                            Text("Connect and manage volunteers with ease", textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Login", textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                                Text("Please sign in to continue", textAlign: TextAlign.center),
                              ],
                            ),
                            SizedBox(height: 40),
                            CustomTextFormField(
                              hintText: 'Email',
                              controller: _emailController,
                              validator: (val) => HelperFunctions.validateEmail(val) ? null : 'Please enter a valid email address',
                            ),
                            SizedBox(height: 12),
                            CustomTextFormField(
                              hintText: 'Password',
                              controller: _passwordController,
                              obscureText: true,
                            ),
                            SizedBox(height: 42),
                            CustomElevatedButton(
                              onPressed: () {
                                if ((_formKey.currentState?.validate()) ?? false) {
                                  _loginBloc.add(FormSubmitted(email: _emailController.text, password: _passwordController.text));
                                }
                              },
                              isLoading: state is LoginLoading,
                              child: Text('Login'),
                            ),
                          ],
                        ),
                      ),
                    ),
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
