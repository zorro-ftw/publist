import 'package:flutter/material.dart';

class DateSelection extends StatefulWidget {
  DateSelection({@required this.selectDate});
  final Future selectDate;

  @override
  _DateSelectionState createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: DropdownButton<String>(
          value: 'Today',
          items: [
            DropdownMenuItem(
              child: Text('Today'),
              value: 'Today',
            ),
            DropdownMenuItem(
              child: Text('This week'),
              value: 'Today',
            ),
            DropdownMenuItem(
              child: Text('This month'),
              value: 'Month',
            ),
            DropdownMenuItem(
              child: TextButton(
                onPressed: () async {
                  selectedDate = await widget.selectDate;
                },
                child: Text('Select a date'),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              // selectedDate = value;
            });
            print(selectedDate);
          },
        ),
      ),
    );
  }
}
