import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AvailabilityPicker extends StatefulWidget {
  final List<DateTime> selectedDates;
  const AvailabilityPicker({super.key, required this.selectedDates});

  @override
  State<AvailabilityPicker> createState() => _AvailabilityPickerState();
}

class _AvailabilityPickerState extends State<AvailabilityPicker> {
  final _fieldKey = GlobalKey<FormFieldState>();

  Future<void> _pickDate() async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (selected != null && !widget.selectedDates.contains(selected)) {
      setState(() {
        widget.selectedDates.add(selected);
        _fieldKey.currentState?.validate(); // Trigger validation after adding a date
      });
    }
  }

  void _removeDate(DateTime date) {
    setState(() {
      widget.selectedDates.remove(date);
      _fieldKey.currentState?.validate(); // Trigger validation after removing a date
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<DateTime>>(
      key: _fieldKey,
      validator: (value) {
        if (widget.selectedDates.isEmpty) {
          return 'Required';
        }
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Availability',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _pickDate,
              child: Text('Pick Date'),
            ),
            SizedBox(height: 16.0),
            if (widget.selectedDates.isEmpty)
              Text(
                'No dates selected.',
                style: TextStyle(color: Colors.grey),
              ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: widget.selectedDates.map((date) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                return Chip(
                  label: Text(formattedDate),
                  onDeleted: () => _removeDate(date),
                );
              }).toList(),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}
