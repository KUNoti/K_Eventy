import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k_eventy/core/constants/constants.dart';
import 'package:k_eventy/features/event/data/models/event.dart';
import 'package:k_eventy/features/event/domain/entities/event.dart';
import 'package:k_eventy/features/event/presentation/bloc/event/remote/remote_event_bloc.dart';
import 'package:k_eventy/features/event/presentation/bloc/event/remote/remote_event_event.dart';
import 'package:k_eventy/features/event/presentation/widgets/map/place_picker/entities/location_result.dart';
import 'package:k_eventy/features/event/presentation/widgets/map/place_picker/place_picker.dart';
import 'package:k_eventy/features/users/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateEventDialog extends StatefulWidget {
  const CreateEventDialog({Key? key}) : super(key: key);

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
  num? lat;
  num? long;

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    _locationNameController.dispose();
    super.dispose();
  }

  //image
  final ImagePicker _picker = ImagePicker();

  void createEvents(BuildContext context) {
    final RemoteAuthBloc remoteAuthBloc = BlocProvider.of<RemoteAuthBloc>(context);

    final user = remoteAuthBloc.user;

    if(user != null) {
      EventEntity event = EventEntity(
          title: _titleController.text,
          latitude: lat,
          longitude: long,
          startDateTime: combineDateTime(_selectedStartDate, _selectedStartTime),
          endDateTime: combineDateTime(_selectedEndDate, _selectedEndTime),
          price: 0.0,
          imageFile: _image,
          creator: user.userId, // userId
          detail: _detailController.text,
          locationName: _locationNameController.text,
          needRegis: false,
          tag: "KU"
      );
      BlocProvider.of<RemoteEventsBloc>(context).add(CreateEvent(event));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.grey,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildImageView(),
                    // Image picker button
                    _buildImagePickerButton(),
                    // Input
                    _buildInput(context),
                    const SizedBox(height: 10),
                    // Date Selector,
                    _buildDateSelector(context),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _locationNameController,
                      decoration: const InputDecoration(
                        labelText: 'Location Name',
                      ),
                    ),
                    _buildPlacePicker()
                  ],
                ),
              ),
            ),
          ),
          _buildButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
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
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: () {
            // Save the event or perform other actions here
            createEvents(context);
          },
          child: const Text('Create'),
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext context) {
    return Column(
      children: [
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
        )
      ],
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return Column(
      children: [
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
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
                    labelText: 'End Time',
                    suffixIcon: Icon(Icons.access_time),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildImageView() {
    return SizedBox(
      child: _image != null
        ? Image.file(
        File(_image!.path),
        fit: BoxFit.cover,
        height: 200,
        width: 200,
        )
        : Image.network(
        kDefaultImage,
        fit: BoxFit.cover,
        height: 200,
        width: 200,
        ),
    );
  }

  Widget _buildImagePickerButton() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: FloatingActionButton(
            onPressed: () {
              _onImageButtonPressed(ImageSource.gallery, context: context);
            },
            heroTag: 'media',
            tooltip: 'Pick Single Media from gallery',
            child: const Icon(Icons.photo_library),
          ),
        ),
        if (_picker.supportsImageSource(ImageSource.camera))
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0),
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image2',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
      ],
    );
  }

  Future<void> _onImageButtonPressed(
      ImageSource source, {
        required BuildContext context,
      }) async {
        Map<Permission, PermissionStatus> status = await [
          Permission.camera,
          Permission.storage,
        ].request();

        if (status[Permission.camera] != PermissionStatus.granted ||
            status[Permission.camera] != PermissionStatus.granted) {
          return;
        }

        XFile? pickedFile = await _picker.pickImage(source: source);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile!.path);
        });
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedStartDate) {
      setState(() {
        _selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );
    if (picked != null && picked != _selectedStartTime) {
      setState(() {
        _selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );
    if (picked != null && picked != _selectedEndTime) {
      setState(() {
        _selectedEndTime = picked;
      });
    }
  }

  Widget _buildPlacePicker() {
    return Center(
      child: ElevatedButton(
        onPressed: ()  {
          showPlacePicker();
        },
        child: const Text("Pick Location"),
      ),
    );
  }

  void showPlacePicker() async {
    LocationResult? result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PlacePicker("AIzaSyAU4HJKQ5Yor8aQNY8c8fHzMDbZnEEB0xs")));

    _locationNameController.text = result?.name ?? "name";
    lat = result?.latLng?.latitude ?? 13.8476;
    long = result?.latLng?.longitude ?? 100.5696;
  }

  DateTime combineDateTime(DateTime date, TimeOfDay timeOfDay) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }
}
