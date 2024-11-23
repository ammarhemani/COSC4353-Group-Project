import 'package:flutter/material.dart';

class AdministratorViewWidget extends StatelessWidget {
  const AdministratorViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: const [
          Icon(Icons.info_outline, size: 12),
          SizedBox(width: 4),
          Text("Only administrators can access this screen"),
        ],
      ),
    );
  }
}
