import 'package:cosc4353_volunteer_app/blocs/profile/profile_bloc.dart';
import 'package:cosc4353_volunteer_app/models/address.dart';
import 'package:cosc4353_volunteer_app/models/user.dart';
import 'package:cosc4353_volunteer_app/screens/home_screen.dart';
import 'package:cosc4353_volunteer_app/screens/landing_screen.dart';
import 'package:cosc4353_volunteer_app/services/constants.dart';
import 'package:cosc4353_volunteer_app/widgets/availability_picker.dart';
import 'package:cosc4353_volunteer_app/widgets/custom_text_form_field.dart';
import 'package:cosc4353_volunteer_app/widgets/skill_chips_field.dart';
import 'package:cosc4353_volunteer_app/widgets/custom_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProfileBloc _profileBloc = ProfileBloc();

  String? selectedState = 'TX';
  final Map<String, bool> selectedSkills = {};
  final List<DateTime> availabilityDates = [];

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _preferencesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize all skills as unselected
    for (var skill in kSkills) {
      selectedSkills[skill] = false;
    }

    // Assign fields if there are previously saved values
    _firstNameController.text = User.instance.firstName ?? '';
    _lastNameController.text = User.instance.lastName ?? '';
    _address1Controller.text = User.instance.address?.address1 ?? '';
    _address2Controller.text = User.instance.address?.address2 ?? '';
    _cityController.text = User.instance.address?.city ?? '';
    _zipCodeController.text = User.instance.address?.zipCode ?? '';
    _preferencesController.text = User.instance.preferences ?? '';

    print("address1: ${User.instance.address?.address1}");
    print(User.instance.address?.address2);
    print(User.instance.address?.city);
    print(User.instance.address?.state);
    print(User.instance.address?.zipCode);

    final skills = User.instance.skills;
    if (skills != null) {
      selectedSkills.addAll(skills);
    }

    final dates = User.instance.availabilityDates;
    if (dates != null) {
      availabilityDates.addAll(dates);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if ((_formKey.currentState?.validate() ?? false)) {
                final Address addressObj = Address(
                  address1: _address1Controller.text,
                  address2: _address2Controller.text,
                  city: _cityController.text,
                  state: selectedState,
                  zipCode: _zipCodeController.text,
                );
                final User updatedUserObj = User(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  address: addressObj,
                  skills: selectedSkills,
                  availabilityDates: availabilityDates,
                  preferences: _preferencesController.text,
                  userType: User.instance.userType,
                );
                _profileBloc.add(UpdateProfile(updatedUserObj: updatedUserObj));
              }
            },
          ),
          // logout button
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              User.instance.logoutUser();
              // push replacement to landingscreen and remove all routes
              Navigator.pushNamedAndRemoveUntil(context, LandingScreen.id, (route) => false);
            },
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: _profileBloc,
        listener: (context, state) {
          if (state is ProfileUpdated) {
            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextFormField(controller: _firstNameController, hintText: 'First Name*', maxLength: 50),
                            SizedBox(height: 12),
                            CustomTextFormField(controller: _lastNameController, hintText: 'Last Name*', maxLength: 50),
                            SizedBox(height: 12),
                            CustomTextFormField(controller: _address1Controller, hintText: 'Address 1*', maxLength: 100),
                            SizedBox(height: 12),
                            CustomTextFormField(controller: _address2Controller, hintText: 'Address 2', required: false, maxLength: 100),
                            SizedBox(height: 12),
                            CustomTextFormField(controller: _cityController, hintText: 'City*', maxLength: 100),
                            SizedBox(height: 12),
                            CustomDropdownField(
                              selectedValue: selectedState,
                              onChanged: (value) => selectedState = value,
                              options: kStates,
                              labelText: "State*",
                              validator: (String? value) => kStates.contains(value) ? null : "Required",
                            ),
                            SizedBox(height: 12),
                            CustomTextFormField(controller: _zipCodeController, hintText: 'Zip code*', maxLength: 9),
                            SizedBox(height: 12),
                            SkillChipsField(selectedSkills: selectedSkills),
                            SizedBox(height: 12),
                            CustomTextFormField(
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              controller: _preferencesController,
                              hintText: 'Preferences',
                              maxLength: 500,
                            ),
                            SizedBox(height: 12),
                            AvailabilityPicker(selectedDates: availabilityDates),
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
