import 'dart:io';

import 'package:event_proposal_app/bloc/bloc.dart';
import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../router/router.dart';
import '../theme/ui_colors.dart';

class FormProposeEvent extends StatefulWidget {
  const FormProposeEvent({super.key});

  @override
  FormProposeEventState createState() => FormProposeEventState();
}

class FormProposeEventState extends State<FormProposeEvent> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _quotaController = TextEditingController();
  final TextEditingController _scheduleLinkController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<CategoryDataModel> _categories = [];

  String? _selectedCategory;

  DateTime? _startDate, _endDate;
  TimeOfDay? _startTime, _endTime;

  File? _selectedImage;

  EventDataModel? eventProposeData;

  String? token;

  String formatTime24Hour(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      token = authState.authData.token!;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    // if (_formKey.currentState!.validate() && _selectedImage != null) {
    eventProposeData = EventDataModel(
      // eventId: null, // Sesuaikan jika Anda memiliki ID event
      title: _titleController.text,
      categoryId: _selectedCategory,
      description: _descriptionController.text,
      imagePoster: _selectedImage,
      location: _locationController.text,
      place: _placeController.text,
      quota: int.tryParse(_quotaController.text) ?? 0,
      dateStart: _startDate != null && _startTime != null
          ? "${_startDate!.toIso8601String().split('T')[0]} ${formatTime24Hour(_startTime!)}"
          : '',
      dateEnd: _endDate != null && _endTime != null
          ? "${_endDate!.toIso8601String().split('T')[0]} ${formatTime24Hour(_endTime!)}"
          : null,
      schedule: _scheduleLinkController.text,
      invitedPersons: null, // Diisi jika ada daftar orang yang diundang
    );
    // final textData = _textController.text;
    // Kirim ke BLoC
    context
        .read<EventBloc>()
        .add(EventProposed(eventData: eventProposeData!, token: token!));
    debugPrint(
        "Date Add: ${_startDate!.toIso8601String().split('T')[0]} ${_startTime!.format(context)}");
    // debugPrint('Token: $token!');
    // debugPrint('Image Path: ${_selectedImage!.path}');
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Please fill all fields and select an image')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColor.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            surfaceTintColor: UIColor.solidWhite,
            elevation: 0,
            // pinned: true,
            // expandedHeight: MediaQuery.of(context).size.width /
            //     1.4, //! Buat tinggi gambar berbanding dengan lebar layar
            leading: IconButton(
              color:
                  // _isScrolled ?
                  // UIColor.typoBlack,
                  // :
                  UIColor.typoBlack,
              icon: Icon(UIconsPro.regularRounded.angle_small_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            title: Text(
              "Propose Form",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    // _isScrolled ?
                    // UIColor.typoBlack,
                    // :
                    UIColor.typoBlack,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocConsumer<EventBloc, EventState>(
              listener: (context, state) {
                if (state is EventProposeSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Propose event success!")));
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.loginRoute,
                      (Route<dynamic> route) => false,
                    );
                  });
                } else if (state is EventError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildField(
                            icon: UIconsPro.regularRounded.head_side_brain,
                            "Title",
                            "Enter title",
                            _titleController),
                        buildDropdown("Category", _categories, (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        }, _selectedCategory),
                        buildField("Place", "Enter place", _placeController),
                        buildField(
                            "Location", "Enter location", _locationController),
                        buildField("Quota", "Enter quota", _quotaController,
                            inputType: TextInputType.number),
                        Flex(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          direction: Axis.horizontal,
                          children: [
                            buildDateTimePicker("Date Start", (date) {
                              setState(() {
                                _startDate = date;
                              });
                            }, _startDate),
                            buildTimePicker("Time Start", (time) {
                              setState(() {
                                _startTime = time;
                              });
                            }, _startTime),
                          ],
                        ),
                        Flex(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          direction: Axis.horizontal,
                          children: [
                            buildDateTimePicker("Date End", (date) {
                              setState(() {
                                _endDate = date;
                              });
                            }, _endDate),
                            buildTimePicker("Time End", (time) {
                              setState(() {
                                _endTime = time;
                              });
                            }, _endTime),
                          ],
                        ),
                        buildField("Schedule Link", "Enter schedule link",
                            _scheduleLinkController),
                        buildField("Description", "Enter description",
                            _descriptionController),
                        // const SizedBox(height: 10),
                        Text(
                          "Poster",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: _selectedImage == null
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(UIconsPro.regularRounded.upload,
                                            size: 24),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          'Click to upload',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          'Supported formats: JPEG, PNG, GIF',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  )
                                : Image.file(_selectedImage!,
                                    fit: BoxFit.cover),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     // Implement file picker logic
                        //   },
                        //   child: Container(
                        //     margin: const EdgeInsets.symmetric(vertical: 10),
                        //     padding: const EdgeInsets.all(20),
                        //     decoration: BoxDecoration(
                        //       border: Border.all(color: UIColor.typoGray),
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //     child: const Center(
                        //       child: Text(
                        //         "Click to upload\nSupported formats: JPEG, PNG, GIF",
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(color: UIColor.typoGray),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Implement submission logic
                            _submitForm();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: UIColor.white,
                            backgroundColor: UIColor.primary,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                UIconsPro.regularRounded.cloud_upload,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Submit",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: UIColor.solidWhite,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildField(String label, String hint, TextEditingController controller,
      {IconData? icon, TextInputType? inputType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            keyboardType: inputType ?? TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              hintStyle: TextStyle(
                  color: UIColor.typoGray, fontWeight: FontWeight.w400),
              hintText: hint,
              fillColor: UIColor.solidWhite,
              prefixIcon: icon != null
                  ? Icon(
                      icon,
                      color: UIColor.typoBlack,
                      size: 20,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Menetapkan border radius
                borderSide: BorderSide.none, // Menghilangkan outline
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown(String label, List<CategoryDataModel> items,
      Function(String?) onChanged, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoaded) {
                _categories = state.categoryData.categories!;
                return DropdownButtonFormField<String>(
                  dropdownColor: UIColor.solidWhite,
                  icon: Icon(
                    UIconsPro.regularRounded.angle_small_down,
                    size: 20,
                  ),
                  value: value,
                  decoration: InputDecoration(
                    hintText: 'Choose category',
                    hintStyle: TextStyle(
                        color: UIColor.typoGray, fontWeight: FontWeight.w400),
                    filled: true,
                    fillColor: UIColor.solidWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Menetapkan border radius
                      borderSide: BorderSide.none, // Menghilangkan outline
                    ),
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item.categoryId.toString(),
                            child: Text(item.categoryName),
                          ))
                      .toList(),
                  onChanged: onChanged,
                );
              } else {
                return DropdownButtonFormField<String>(
                  icon: Icon(
                    UIconsPro.regularRounded.angle_small_down,
                    size: 20,
                  ),
                  value: value,
                  decoration: InputDecoration(
                    hintText: 'Choose category',
                    hintStyle: TextStyle(
                        color: UIColor.typoGray, fontWeight: FontWeight.w400),
                    filled: true,
                    fillColor: UIColor.solidWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Menetapkan border radius
                      borderSide: BorderSide.none, // Menghilangkan outline
                    ),
                  ),
                  items: [],
                  onChanged: (String? value) {},
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildDateTimePicker(
      String label, Function(DateTime) onChanged, DateTime? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                onChanged(pickedDate);
              }
            },
            child: Container(
              width: (MediaQuery.of(context).size.width / 2) + 44,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: UIColor.solidWhite,
                // border: Border.all(color: UIColor.typoGray),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                value != null
                    ? "${value.toLocal()}".split(' ')[0]
                    : "Pick a date",
                style: const TextStyle(color: UIColor.typoGray),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimePicker(
      String label, Function(TimeOfDay) onChanged, TimeOfDay? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () async {
              final pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                onChanged(pickedTime);
              }
            },
            child: Container(
              width: (MediaQuery.of(context).size.width / 2) - 90,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: UIColor.solidWhite,
                // border: Border.all(color: UIColor.typoGray),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                textAlign: TextAlign.center,
                value != null ? value.format(context) : "00:00",
                style: const TextStyle(color: UIColor.typoGray),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
