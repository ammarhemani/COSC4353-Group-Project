import 'package:flutter/material.dart';

class SkillChipsField extends StatefulWidget {
  final Map<String, bool> selectedSkills;
  const SkillChipsField({super.key, required this.selectedSkills});

  @override
  State<SkillChipsField> createState() => _SkillChipsFieldState();
}

class _SkillChipsFieldState extends State<SkillChipsField> {
  final _fieldKey = GlobalKey<FormFieldState>();

  bool _hasAtLeastOneSkillSelected() {
    return widget.selectedSkills.values.contains(true);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      key: _fieldKey,
      validator: (value) {
        if (!_hasAtLeastOneSkillSelected()) {
          return 'Please select at least one skill.';
        }
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0, // Space between chips
              runSpacing: 4.0, // Space between lines
              children: widget.selectedSkills.keys.map((skill) {
                return FilterChip(
                  label: Text(skill),
                  selected: widget.selectedSkills[skill] ?? false,
                  onSelected: (isSelected) {
                    setState(() {
                      widget.selectedSkills[skill] = isSelected;
                      _fieldKey.currentState?.validate(); // Trigger validation on change
                    });
                  },
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
