import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as GoogleAPI;
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:convert';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});
  static String id = "calendar_screen";

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  static const String calendarId = 'c_9c98a25a21fddc818a66e6ceb915821c0e7db51e9495b2c54d2cae6f38dcfdde@group.calendar.google.com';
  static const String apiKey = 'AIzaSyDl7G03yJCigH-Xj30snIUCajEltOUR3cQ';

  Future<List<GoogleAPI.Event>> fetchCalendarEvents() async {
    // start date of fetching events from
    final DateTime timeMinDate = DateTime.utc(2016, 1, 1);
    final String timeMin = timeMinDate.toIso8601String();

    final Uri url = Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?timeMin=$timeMin&orderBy=startTime&singleEvents=true&key=$apiKey');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<GoogleAPI.Event> events = (data['items'] as List)
          .map((e) => GoogleAPI.Event.fromJson(e))
          .toList();
      return events;
    } else {
      throw Exception('Failed to load calendar events');
    }
  }

  // dialog to show event details
  void showEventDetailsDialog(BuildContext context, GoogleAPI.Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event.summary ?? "No Title"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📅 Start: ${event.start?.dateTime?.toLocal() ?? event.start?.date}"),
              Text("⏳ End: ${event.end?.dateTime?.toLocal() ?? event.end?.date}"),
              if (event.location != null) Text("📍 Location: ${event.location}"),
              if (event.description != null) Text("📝 Details: ${event.description}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  // dialog to show multiple events
  void showEventsListDialog(BuildContext context, List<GoogleAPI.Event> events) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Events for this day"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: events.map((event) {
              return ListTile(
                title: Text(event.summary ?? "No Title"),
                onTap: () {
                  Navigator.pop(context);
                  showEventDetailsDialog(context, event);
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<GoogleAPI.Event>>(
        future: fetchCalendarEvents(),
        builder: (BuildContext context, AsyncSnapshot<List<GoogleAPI.Event>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return SfCalendar(
            view: CalendarView.month,
            dataSource: GoogleDataSource(events: snapshot.data!),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
            onTap: (CalendarTapDetails details) {
              if (details.appointments != null && details.appointments!.isNotEmpty) {
                final List<GoogleAPI.Event> selectedEvents =
                List<GoogleAPI.Event>.from(details.appointments!);

                if (selectedEvents.length > 2) {
                  showEventsListDialog(context, selectedEvents);
                } else {
                  showEventDetailsDialog(context, selectedEvents.first);
                }
              }
            },
          );
        },
      ),
    );
  }
}

class GoogleDataSource extends CalendarDataSource {
  GoogleDataSource({required List<GoogleAPI.Event> events}) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    final GoogleAPI.Event event = appointments![index];
    return event.start?.date ?? event.start!.dateTime!.toLocal();
  }

  @override
  DateTime getEndTime(int index) {
    final GoogleAPI.Event event = appointments![index];

    return event.end?.date != null
        ? DateTime.parse(event.end!.date!.toIso8601String()).subtract(const Duration(seconds: 1))
        : (event.end!.dateTime != null && event.end!.dateTime!.hour == 0 && event.end!.dateTime!.minute == 0
        ? event.end!.dateTime!.subtract(const Duration(seconds: 1))
        : event.end!.dateTime!.toLocal());
  }

  @override
  String getSubject(int index) {
    final GoogleAPI.Event event = appointments![index];
    return event.summary ?? 'No Title';
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].start?.date != null;
  }
}