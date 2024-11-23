import 'package:cosc4353_volunteer_app/models/user.dart';
import 'package:cosc4353_volunteer_app/services/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CandidateCard extends StatelessWidget {
  final User candidate;
  const CandidateCard(this.candidate, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${candidate.firstName} ${candidate.lastName}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Address: \n", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: "Address: ${candidate.address?.address1 ?? ""}, \n"),
                  TextSpan(text: "${candidate.address?.city ?? ""}, ${candidate.address?.state ?? ""}, ${candidate.address?.zipCode ?? ""}"),
                ],
              ),
            ),
            SizedBox(height: 12),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Skills: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: candidate.skills?.keys.join(", ")),
                ],
              ),
            ),
            SizedBox(height: 12),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Preferences: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: candidate.preferences ?? ""),
                ],
              ),
            ),
            SizedBox(height: 12),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Availability Dates: \n", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: candidate.availabilityDates?.map((e) => DateFormat('MM/dd/yyyy').format(e)).join(", ") ?? ""),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => SnackBarHelper.showSnackBar(context, 'Accepted', Icon(Icons.check)),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 24),
                  GestureDetector(
                    onTap: () => SnackBarHelper.showSnackBar(context, 'Rejected', Icon(Icons.close)),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
