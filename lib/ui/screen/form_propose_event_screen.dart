import 'dart:io';

import 'package:event_proposal_app/bloc/bloc.dart';
import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/ui/router/router.dart';
import 'package:event_proposal_app/ui/widget/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../theme/ui_colors.dart';

class FormProposeEvent extends StatefulWidget {
  const FormProposeEvent({super.key, required this.categoryData});
  final CategoryModel categoryData;

  @override
  FormProposeEventState createState() => FormProposeEventState();
}

class FormProposeEventState extends State<FormProposeEvent> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _quotaController = TextEditingController();
  final TextEditingController _scheduleLinkController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  String? _selectedCategory;
  File? _selectedImage;
  EventDataModel? eventProposeData;
  String? token;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      token = authState.authData.token!;
    }
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

  Future<void> _pickDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Check if title is null or empty
      if (_titleController.text.isEmpty) {
        showCustomSnackBar(context, 'Title cannot be null or empty');
      }

      // Check if category is null
      if (_selectedCategory == null) {
        showCustomSnackBar(context, 'Category cannot be null');
      }

      // Check if description is null or empty
      if (_descriptionController.text.isEmpty) {
        showCustomSnackBar(context, 'Description cannot be null or empty');
      }

      // Check if image poster is null
      if (_selectedImage == null) {
        showCustomSnackBar(context, 'Image poster cannot be null');
      }

      // Check if location is null or empty
      if (_locationController.text.isEmpty) {
        showCustomSnackBar(context, 'Location cannot be null or empty');
      }

      // Check if place is null or empty
      if (_placeController.text.isEmpty) {
        showCustomSnackBar(context, 'Place cannot be null or empty');
      }

      // Check if quota is null or empty or not a valid number
      if (_quotaController.text.isEmpty ||
          int.tryParse(_quotaController.text) == null) {
        showCustomSnackBar(context, 'Quota must be a valid number');
      }

      // Check if date start is null or empty
      if (_startDateController.text.isEmpty) {
        showCustomSnackBar(context, 'Start date cannot be null or empty');
      }

      // Check if date end is null or empty
      if (_endDateController.text.isEmpty) {
        showCustomSnackBar(context, 'End date cannot be null or empty');
      }

      try {
        eventProposeData = EventDataModel(
          title: _titleController.text,
          categoryId: _selectedCategory,
          description: _descriptionController.text,
          imagePoster: _selectedImage,
          location: _locationController.text,
          place: _placeController.text,
          quota: int.parse(_quotaController.text),
          dateStart: _startDateController.text,
          dateEnd: _endDateController.text,
          schedule:
              _scheduleLinkController.text, // Schedule boleh null atau kosong
          invitedPersons: null,
        );

        debugPrint(eventProposeData.toString());
        context
            .read<EventBloc>()
            .add(EventProposeData(eventData: eventProposeData!, token: token!));
      } catch (e) {
        // showCustomSnackBar(context, e.toString());
        throw ArgumentError(e.toString());
      }
    }
  }

  Widget buildField(String label, String hint, TextEditingController controller,
      {IconData? icon,
      TextInputType? inputType,
      GestureTapCallback? onTap,
      FormFieldValidator<String>? validator,
      bool readonly = false}) {
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
            validator: validator,
            onTap: onTap,
            readOnly: readonly,
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
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown(
    String label,
    List<CategoryDataModel> items,
    Function(String?) onChanged,
    String? value,
  ) {
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
          DropdownMenu<String>(
            menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(UIColor.solidWhite),
                elevation: WidgetStatePropertyAll(0)),
            controller: _categoryController,
            leadingIcon: Icon(
              UIconsPro.regularRounded.apps,
              size: 20,
              color: UIColor.typoBlack,
            ),
            hintText: 'Choose category',
            width: MediaQuery.of(context).size.width - 40,
            initialSelection: value,
            dropdownMenuEntries: items.map((item) {
              return DropdownMenuEntry<String>(
                value: item.categoryId.toString(),
                label: item.categoryName,
              );
            }).toList(),
            onSelected: onChanged,
            trailingIcon: Icon(
              UIconsPro.regularRounded.angle_small_down,
              size: 20,
            ),
            selectedTrailingIcon: Icon(
              UIconsPro.regularRounded.angle_small_up,
              size: 20,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: UIColor.solidWhite,
              hintStyle: TextStyle(
                color: UIColor.typoGray,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Menetapkan border radius
                borderSide: BorderSide.none, // Menghilangkan outline
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryDataModel> categories = widget.categoryData.categories!;

    return Scaffold(
      backgroundColor: UIColor.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            surfaceTintColor: UIColor.solidWhite,
            elevation: 0,
            leading: IconButton(
              color: UIColor.typoBlack,
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
                color: UIColor.typoBlack,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocConsumer<EventBloc, EventState>(
              listener: (context, state) {
                if (state is EventProposed) {
                  showCustomSnackBar(context, "Propose event success!");

                  Navigator.of(context).pushReplacementNamed(
                    AppRouter.detailEventApprovalProposeRoute,
                    arguments: {
                      'event_data':
                          eventProposeData!.copyWith(eventId: state.eventId),
                      'current_role': 'Propose',
                    },
                  );
                } else if (state is EventError) {
                  showCustomSnackBar(context, state.message);
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
                        buildField("Title", "Enter title", _titleController,
                            icon: UIconsPro.regularRounded.head_side_thinking),
                        buildDropdown("Category", categories, (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        }, _selectedCategory),
                        buildField("Place", "Enter place", _placeController,
                            icon: UIconsPro.regularRounded.house_building),
                        buildField(
                            "Location", "Enter location", _locationController,
                            icon: UIconsPro.regularRounded.map_marker),
                        buildField("Quota", "Enter quota", _quotaController,
                            icon: UIconsPro.regularRounded.users_alt,
                            inputType: TextInputType.number),
                        buildField(
                          "Start Date",
                          "Pick start date",
                          _startDateController,
                          icon: UIconsPro.regularRounded.calendar,
                          readonly: true,
                          onTap: () => _pickDate(context, _startDateController),
                        ),
                        buildField(
                          "End Date",
                          "Pick end date",
                          _endDateController,
                          icon: UIconsPro.regularRounded.calendar,
                          readonly: true,
                          onTap: () => _pickDate(context, _endDateController),
                        ),
                        buildField(
                          "Schedule Link",
                          "Enter schedule link",
                          _scheduleLinkController,
                          icon: UIconsPro.regularRounded.link,
                          inputType: TextInputType.url,
                        ),
                        buildField(
                          "Description",
                          "Enter description",
                          _descriptionController,
                          icon: UIconsPro.regularRounded.text,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Poster",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 5),
                              InkWell(
                                onTap: _pickImage,
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: UIColor.solidWhite,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: UIColor.typoGray),
                                  ),
                                  child: _selectedImage == null
                                      ? const Center(
                                          child: Text(
                                            "Tap to upload image",
                                            style: TextStyle(
                                                color: UIColor.typoGray,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      : Image.file(
                                          _selectedImage!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: UIColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: UIColor.white,
                              ),
                            ),
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
}
