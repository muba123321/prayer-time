import 'package:flutter/material.dart';

class IslamicCalendarScreen extends StatelessWidget {
  const IslamicCalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // appBar: AppBar(
      //   title: const Text('Islamic Calendar'),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDatePicker(context),
            const SizedBox(height: 20),
            const Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildEventList(),
            // You can add more sections and widgets as needed
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: InkWell(
        onTap: () {
          // Implement your logic for date picker
          // You can use packages like `showDatePicker` or design a custom one
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.calendar_today),
              SizedBox(width: 10),
              Text(
                'Select Date',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    // Sample list of events, replace with your actual data
    final List<String> events = [
      'Iftar with Family',
      'Tarawih Prayer at Mosque',
      'Islamic Lecture at Community Center',
      // Add more events
    ];

    return Column(
      children: events.map((event) {
        return ListTile(
          title: Text(event),
          // You can customize the ListTile based on your design
        );
      }).toList(),
    );
  }
}

// void main() {
//   runApp(
//     MaterialApp(
//       home: IslamicCalendarScreen(),
//     ),
//   );
// }
