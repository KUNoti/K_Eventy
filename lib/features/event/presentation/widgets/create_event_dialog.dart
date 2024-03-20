import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventDialog extends StatefulWidget {
  const CreateEventDialog({Key? key});

  @override
  _CreateEventDialogState createState() => _CreateEventDialogState();
}

class _CreateEventDialogState extends State<CreateEventDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _locationNameController = TextEditingController();
  File? _image;
  DateTime _selectedStartDate = DateTime.now();
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  DateTime _selectedEndDate = DateTime.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedStartDate)
      setState(() {
        _selectedStartDate = picked;
      });
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );
    if (picked != null && picked != _selectedStartTime)
      setState(() {
        _selectedStartTime = picked;
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedEndDate)
      setState(() {
        _selectedEndDate = picked;
      });
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );
    if (picked != null && picked != _selectedEndTime)
      setState(() {
        _selectedEndTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Add Event',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: _image != null
                              ? Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  'https://via.placeholder.com/400x300',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    TextField(
                      controller: _detailController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Detail',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectStartDate(context),
                            child: TextField(
                              controller: TextEditingController(
                                text:
                                    '${_selectedStartDate.day}/${_selectedStartDate.month}/${_selectedStartDate.year}',
                              ),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Start Date',
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectStartTime(context),
                            child: TextField(
                              controller: TextEditingController(
                                text:
                                    '${_selectedStartTime.hour}:${_selectedStartTime.minute}',
                              ),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Start Time',
                                suffixIcon: Icon(Icons.access_time),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectEndDate(context),
                            child: TextField(
                              controller: TextEditingController(
                                text:
                                    '${_selectedEndDate.day}/${_selectedEndDate.month}/${_selectedEndDate.year}',
                              ),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'End Date',
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectEndTime(context),
                            child: TextField(
                              controller: TextEditingController(
                                text:
                                    '${_selectedEndTime.hour}:${_selectedEndTime.minute}',
                              ),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'End Time',
                                suffixIcon: Icon(Icons.access_time),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _locationNameController,
                      decoration: const InputDecoration(
                        labelText: 'Location Name',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  // Save the event or perform other actions here
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
