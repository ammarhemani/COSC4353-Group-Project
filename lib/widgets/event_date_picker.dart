import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDatePicker extends StatefulWidget {
  final String label;
  final Function(DateTime) onDateSelected;
  const EventDatePicker({super.key, required this.label, required this.onDateSelected});
  @override
  State<EventDatePicker> createState() => _EventDatePickerState();
}

class _EventDatePickerState extends State<EventDatePicker> {
  String? selectedDate;

  Future<void> selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
        widget.onDateSelected(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: selectedDate ?? 'Select ${widget.label}',
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () => selectDate(context),
            ),
          ),
        ),
      ],
    );
  }
}
