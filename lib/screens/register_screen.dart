import 'package:cosc4353_volunteer_app/blocs/register/register_bloc.dart';
import 'package:cosc4353_volunteer_app/screens/profile_screen.dart';
import 'package:cosc4353_volunteer_app/services/helper_functions.dart';
import 'package:cosc4353_volunteer_app/widgets/custom_elevated_button.dart';
import 'package:cosc4353_volunteer_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegisterBloc _registerBloc = RegisterBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(forceMaterialTransparency: true),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        bloc: _registerBloc,
        listener: (context, state) {
          if (state is RegisterLoaded) {
            Navigator.pushNamedAndRemoveUntil(context, ProfileScreen.id, (route) => false);
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is RegisterLoading,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.blue[300],
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text(
                              "VolunteerConnect",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            Text("Join now to make a difference!", textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Register",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                ),
                                Text("Please create an account to continue", textAlign: TextAlign.center),
                              ],
                            ),
                            SizedBox(height: 40),
                            CustomTextFormField(controller: _firstNameController, hintText: 'First Name'),
                            SizedBox(height: 12),
                            CustomTextFormField(controller: _lastNameController, hintText: 'Last Name'),
                            SizedBox(height: 12),
                            CustomTextFormField(
                              controller: _emailController,
                              hintText: 'Email',
                              validator: (val) => HelperFunctions.validateEmail(val) ? null : 'Please enter a valid email address',
                            ),
                            SizedBox(height: 12),
                            CustomTextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              hintText: 'Password',
                              validator: (value) {
                                if ((value == null || value.isEmpty)) {
                                  return 'Required';
                                } else {
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 42),
                            CustomElevatedButton(
                              onPressed: () {
                                if ((_formKey.currentState?.validate()) ?? false) {
                                  _registerBloc.add(
                                    FormSubmitted(
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                }
                              },
                              isLoading: state is RegisterLoading,
                              child: Text('Register'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
