import 'package:cosc4353_volunteer_app/blocs/events/events_bloc.dart';
import 'package:cosc4353_volunteer_app/models/event.dart';
import 'package:cosc4353_volunteer_app/services/constants.dart';
import 'package:cosc4353_volunteer_app/widgets/administrator_view_widget.dart';
import 'package:cosc4353_volunteer_app/widgets/custom_dropdown_field.dart';
import 'package:cosc4353_volunteer_app/widgets/custom_text_form_field.dart';
import 'package:cosc4353_volunteer_app/widgets/event_date_picker.dart';
import 'package:cosc4353_volunteer_app/widgets/multi_select_dropdown.dart';
import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  static const String id = 'create_event_screen';
  final EventsBloc eventsBloc;
  const CreateEventScreen({super.key, required this.eventsBloc});
  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Event event = Event();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Event"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if ((_formKey.currentState?.validate() ?? false)) {
                widget.eventsBloc.add(CreateEvent(event));
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AdministratorViewWidget(),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    hintText: 'Event Name*',
                    maxLength: 100,
                    onChanged: (value) => event.name = value,
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                    hintText: 'Event Description*',
                    maxLines: 5,
                    maxLength: 500,
                    onChanged: (value) => event.description = value,
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                    hintText: 'Location*',
                    onChanged: (value) => event.location = value,
                  ),
                  const SizedBox(height: 12),
                  MultiSelectDropdown(
                    label: 'Required Skills*',
                    options: kSkills,
                    onSelectionChanged: (skills) => setState(() => event.requiredSkills = skills),
                  ),
                  const SizedBox(height: 20),
                  CustomDropdownField(
                    selectedValue: event.urgency,
                    onChanged: (value) => event.urgency = value,
                    options: kUrgencies,
                    labelText: "Urgency*",
                    validator: (String? value) => value != null ? null : "Required",
                  ),
                  const SizedBox(height: 12),
                  EventDatePicker(
                    label: 'Start Date*',
                    onDateSelected: (date) => setState(() => event.startDate = date),
                  ),
                  const SizedBox(height: 12),
                  EventDatePicker(
                    label: 'End Date*',
                    onDateSelected: (date) => setState(() => event.endDate = date),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
