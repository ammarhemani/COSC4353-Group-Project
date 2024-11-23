import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:cosc4353_volunteer_app/models/event.dart';
import 'package:cosc4353_volunteer_app/services/firebase_provider.dart';

class ReportGenerator {
  // Generate PDF report
  static Future<File> generatePDFReport() async {
    final pdf = pw.Document();

    // Fetch all required data
    final events = await FirebaseProvider.fetchEvents();

    // Create a map to store volunteer participation data
    Map<String, List<Event>> volunteerParticipation = {};

    // Process events to gather volunteer participation
    for (var event in events) {
      for (var volunteerId in event.volunteers) {
        if (!volunteerParticipation.containsKey(volunteerId)) {
          volunteerParticipation[volunteerId] = [];
        }
        volunteerParticipation[volunteerId]!.add(event);
      }
    }

    // Fetch volunteer details
    final db = FirebaseFirestore.instance;
    Map<String, Map<String, dynamic>> volunteerDetails = {};

    for (var volunteerId in volunteerParticipation.keys) {
      final volunteerDoc = await db.collection('users').doc(volunteerId).get();
      if (volunteerDoc.exists) {
        volunteerDetails[volunteerId] = volunteerDoc.data() ?? {};
      }
    }

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(level: 0, child: pw.Text('Volunteer Activity Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold))),

          // Events Summary Section
          pw.Header(level: 1, child: pw.Text('Events Summary')),
          pw.Table.fromTextArray(
            context: context,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            data: [
              ['Event Name', 'Date', 'Location', 'Volunteers'],
              ...events.map((event) => [
                    event.name ?? 'N/A',
                    '${event.startDate?.toString().split(' ')[0]} - ${event.endDate?.toString().split(' ')[0]}',
                    event.location ?? 'N/A',
                    event.volunteers.length.toString(),
                  ]),
            ],
          ),

          pw.SizedBox(height: 20),

          // Volunteer Participation Section
          pw.Header(level: 1, child: pw.Text('Volunteer Participation')),

          // Overall Statistics
          pw.Paragraph(
            text: 'Total Active Volunteers: ${volunteerParticipation.length}',
            style: pw.TextStyle(fontSize: 14),
          ),
          pw.Paragraph(
            text: 'Total Events: ${events.length}',
            style: pw.TextStyle(fontSize: 14),
          ),

          pw.SizedBox(height: 10),

          // Detailed Volunteer Participation
          ...volunteerParticipation.entries.map((entry) {
            final volunteerData = volunteerDetails[entry.key];
            final volunteerEvents = entry.value;

            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey200,
                  ),
                  padding: pw.EdgeInsets.all(10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        '${volunteerData?['first_name']} ${volunteerData?['last_name']}',
                        style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text('Email: ${volunteerData?['email'] ?? 'N/A'}'),
                      pw.Text('Events Participated: ${volunteerEvents.length}'),

                      pw.SizedBox(height: 5),

                      pw.Table.fromTextArray(
                        context: context,
                        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        data: [
                          ['Event', 'Date', 'Location'],
                          ...volunteerEvents.map((event) => [
                                event.name ?? 'N/A',
                                '${event.startDate?.toString().split(' ')[0]}',
                                event.location ?? 'N/A',
                              ]),
                        ],
                      ),

                      // Skills section if available
                      if (volunteerData?['skills'] != null) ...[
                        pw.SizedBox(height: 5),
                        pw.Text(
                          'Skills: ${(volunteerData?['skills'] as Map<String, dynamic>).entries.where((e) => e.value == true).map((e) => e.key).join(', ')}',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
              ],
            );
          }),
        ],
      ),
    );

    // Save the PDF
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/volunteer_report.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  // Enhanced CSV report to match PDF content
  static Future<File> generateCSVReport() async {
    final events = await FirebaseProvider.fetchEvents();
    final db = FirebaseFirestore.instance;

    // Create two separate sheets within the CSV

    // 1. Events Summary Sheet
    List<List<dynamic>> eventSummaryRows = [
      ['EVENTS SUMMARY'],
      [], // Empty row for spacing
      ['Event Name', 'Start Date', 'End Date', 'Location', 'Required Skills', 'Number of Volunteers']
    ];

    for (var event in events) {
      eventSummaryRows.add([
        event.name ?? 'N/A',
        event.startDate?.toString().split(' ')[0] ?? 'N/A',
        event.endDate?.toString().split(' ')[0] ?? 'N/A',
        event.location ?? 'N/A',
        event.requiredSkills.join(', '),
        event.volunteers?.length ?? 0,
      ]);
    }

    // Add total statistics
    eventSummaryRows.addAll([
      [], // Empty row for spacing
      ['Total Events:', events.length],
      ['Average Volunteers per Event:', events.fold<double>(0, (sum, event) => sum + (event.volunteers?.length ?? 0)) / events.length],
    ]);

    // 2. Volunteer Participation Sheet
    List<List<dynamic>> volunteerRows = [
      [], // Empty row for spacing
      ['VOLUNTEER PARTICIPATION'],
      [], // Empty row for spacing
      ['Volunteer Name', 'Email', 'Skills', 'Total Events Participated', 'Participated Events (Name, Date, Location)']
    ];

    // Process events to gather volunteer participation
    Map<String, List<Event>> volunteerParticipation = {};
    Set<String> allVolunteerIds = {};

    // Gather all volunteer IDs and their participated events
    for (var event in events) {
      if (event.volunteers != null) {
        for (var volunteerId in event.volunteers!) {
          allVolunteerIds.add(volunteerId);
          if (!volunteerParticipation.containsKey(volunteerId)) {
            volunteerParticipation[volunteerId] = [];
          }
          volunteerParticipation[volunteerId]!.add(event);
        }
      }
    }

    // Fetch and process volunteer details
    for (var volunteerId in allVolunteerIds) {
      final volunteerDoc = await db.collection('users').doc(volunteerId).get();
      if (volunteerDoc.exists) {
        final volunteerData = volunteerDoc.data() ?? {};
        final participatedEvents = volunteerParticipation[volunteerId] ?? [];

        // Format participated events as a single string
        final eventsString = participatedEvents.map((event) => '${event.name} (${event.startDate?.toString().split(' ')[0]}, ${event.location})').join(' | ');

        // Get skills
        final skills = (volunteerData['skills'] as Map<String, dynamic>?)?.entries?.where((e) => e.value == true)?.map((e) => e.key)?.join(', ') ?? '';

        volunteerRows.add([
          '${volunteerData['first_name']} ${volunteerData['last_name']}',
          volunteerData['email'],
          skills,
          participatedEvents.length,
          eventsString,
        ]);
      }
    }

    // Add overall volunteer statistics
    volunteerRows.addAll([
      [], // Empty row for spacing
      ['Total Active Volunteers:', allVolunteerIds.length],
      ['Average Events per Volunteer:', volunteerParticipation.values.fold<double>(0, (sum, events) => sum + events.length) / allVolunteerIds.length],
    ]);

    // Combine all rows with section separators
    List<List<dynamic>> allRows = [
      ...eventSummaryRows,
      [], [], // Empty rows for spacing between sections
      ...volunteerRows,
    ];

    String csv = const ListToCsvConverter().convert(allRows);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/volunteer_report.csv');
    await file.writeAsBytes(csv.codeUnits);
    return file;
  }

  // Share report
  static Future<void> shareReport(String format) async {
    File reportFile;

    if (format == 'pdf') {
      reportFile = await generatePDFReport();
    } else {
      reportFile = await generateCSVReport();
    }

    await Share.shareXFiles(
      [XFile(reportFile.path)],
      subject: 'Volunteer Activity Report',
    );
  }
}
