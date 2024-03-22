import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:k_eventy/features/event/presentation/pages/test_page.dart';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CreateEventDialog extends StatefulWidget {
  const CreateEventDialog({super.key});

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

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    _locationNameController.dispose();
    super.dispose();
  }

  //image
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _mediaFileList;
  String? _retrieveDataError;

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;

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

  Future<void> _onImageButtonPressed(
      ImageSource source, {
        required BuildContext context,
    }) async {
    if (context.mounted) {
      try {
        final XFile? pickedFile = await _picker.pickImage(source: source);
        setState(() {
          _setImageFileListFromFile(pickedFile);
        });
      } catch (e) {
        setState(() {
         _pickImageError = e;
        });
      }
    }
  }

  Widget _buildInlineVideoPlayer(int index) {
    final VideoPlayerController controller =
    VideoPlayerController.file(File(_mediaFileList![index].path));
    const double volume = kIsWeb ? 0.0 : 1.0;
    controller.setVolume(volume);
    controller.initialize();
    controller.setLooping(true);
    controller.play();
    return Center(child: AspectRatioVideo(controller));
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_mediaFileList != null) {
      return Semantics(
        label: "image",
        child: ListView.builder(
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int index) {
              final String? mime = lookupMimeType(_mediaFileList![index].path);

              return Semantics(
                label: 'image_picker_example_picked_image',
                child: kIsWeb
                    ? Image.network(_mediaFileList![index].path)
                    : (mime == null || mime.startsWith('image/')
                    ? SizedBox(
                      width: 400,
                      height: 300,
                      child: Image.file(
                                        File(_mediaFileList![index].path),
                                        errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return const Center(
                          child:
                          Text('This image type is not supported'));
                                        },
                                      ),
                    )
                    : _buildInlineVideoPlayer(index)),
              );
            }
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          const Text(
          'You have not yet picked an image.',
          textAlign: TextAlign.center,
          ),
          Image.network(
            'https://via.placeholder.com/400x300',
            fit: BoxFit.cover,
          )
        ],
      );
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }




  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _previewImages(),
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
                icon: const Icon(Icons.close),
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

                    // Image picker button
                    Row(
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
                    ),

                    // Input
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
