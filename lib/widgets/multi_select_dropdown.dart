import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final String label;
  final List<String> options;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectDropdown({
    super.key,
    required this.label,
    required this.options,
    required this.onSelectionChanged,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> _selectedItems = [];

  void _showMultiSelectDialog(BuildContext context) {
    // Create a copy of _selectedItems for the dialog state
    List<String> dialogSelectedItems = List.from(_selectedItems);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(widget.label),
              content: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: ListBody(
                  children: widget.options.map((item) {
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero, // Reduced padding
                      value: dialogSelectedItems.contains(item),
                      title: Text(item),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? isChecked) {
                        setDialogState(() {
                          if (isChecked!) {
                            dialogSelectedItems.add(item);
                          } else {
                            dialogSelectedItems.remove(item);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    // Update the main state with dialog changes
                    setState(() => _selectedItems = List.from(dialogSelectedItems));
                    widget.onSelectionChanged(_selectedItems);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.label),
        GestureDetector(
          onTap: () => _showMultiSelectDialog(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _selectedItems.isEmpty ? 'Select ${widget.label}' : _selectedItems.join(', '),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
