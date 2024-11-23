import 'package:cosc4353_volunteer_app/services/constants.dart';
import 'package:flutter/material.dart';

class StateDropdownField extends StatelessWidget {
  final String? selectedState;
  final Function(String?) onChanged;
  const StateDropdownField({super.key, required this.selectedState, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedState,
      validator: (String? value) => kStates.contains(value) ? null : "Required",
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: "State*",
        isDense: false,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
      ),
      isExpanded: true,
      icon: Icon(Icons.keyboard_arrow_down),
      items: kStates.map((String stateAbbr) {
        return DropdownMenuItem<String>(
          value: stateAbbr,
          child: Text(stateAbbr),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
