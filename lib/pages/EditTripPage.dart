// pages/EditTripPage.dart
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// class EditTripPage extends StatefulWidget {
//   final Map<String, dynamic> trip;

//   const EditTripPage({super.key, required this.trip});

//   @override
//   State<EditTripPage> createState() => _EditTripPageState();
// }

// class _EditTripPageState extends State<EditTripPage> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController titleController;
//   late TextEditingController descriptionController;
//   late TextEditingController destinationController;
//   late TextEditingController startDateController;
//   late TextEditingController endDateController;
//   late TextEditingController availableController;
//   late TextEditingController priceController;
//   late TextEditingController mapLocationController;

//   File? imageFile;
//   String selectedCategory = "Funny";

//   final List<String> categories = ["Funny", "Medicine", "History"];

//   final String token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJtb2hhbWVkYXphbHk3NzJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiI4ZTA0OTA5NS01NzY4LTQyN2QtYWNmNy02NjU0ZGMxMmFlMGYiLCJqdGkiOiI4OWE2NzdkMS0yNzBjLTQ1YzItYmIzNC0zMTgwNmJkZTExNWIiLCJVc2VyVHlwZSI6Ik93bmVyIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiT3duZXIiLCJleHAiOjE3NDkwNzc3OTQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDY5NTAiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjU1NTU1In0.lFdnvnr1my2tGWfHQoUEzuNes5KL_KfkRY0HWHPSDgg";

//   @override
//   void initState() {
//     super.initState();
//     titleController = TextEditingController(text: widget.trip['title']);
//     descriptionController = TextEditingController(text: widget.trip['description']);
//     destinationController = TextEditingController(text: widget.trip['destination']);
//     startDateController = TextEditingController(text: widget.trip['startDate']);
//     endDateController = TextEditingController(text: widget.trip['endDate']);
//     availableController = TextEditingController(text: widget.trip['available']);
//     priceController = TextEditingController(text: widget.trip['price']);
//     mapLocationController = TextEditingController(text: widget.trip['map'] ?? '');
//     selectedCategory = widget.trip['category'] ?? "Funny";
//     imageFile = widget.trip['image'] != null ? File(widget.trip['image'].path) : null;
//   }

//   Future<void> pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: source);
//     if (pickedImage != null) {
//       setState(() {
//         imageFile = File(pickedImage.path);
//       });
//     }
//   }

//   Future<void> _pickDate(TextEditingController controller) async {
//     final DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.tryParse(controller.text) ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (selectedDate != null) {
//       setState(() {
//         controller.text = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
//       });
//     }
//   }

//   Future<void> sendUpdatedTripToServer() async {
//     final uri = Uri.parse('http://20.74.208.111:5260/api/Owners/AddDestinationWithImages');
//     final request = http.MultipartRequest('POST', uri);

//     request.headers['Authorization'] = token;
//     request.headers['accept'] = '*/*';

//     request.fields['Name'] = titleController.text;
//     request.fields['Description'] = descriptionController.text;
//     request.fields['Location'] = destinationController.text;
//     request.fields['StartDate'] = DateTime.parse(startDateController.text).toIso8601String();
//     request.fields['EndtDate'] = DateTime.parse(endDateController.text).toIso8601String();
//     request.fields['AvilableNumber'] = availableController.text;
//     request.fields['Cost'] = priceController.text;
//     request.fields['Discount'] = "0";
//     request.fields['Category'] = selectedCategory;
//     request.fields['MapLocation'] = mapLocationController.text;

//     if (imageFile != null) {
//       request.files.add(await http.MultipartFile.fromPath('ImageData', imageFile!.path));
//     }

//     final response = await request.send();

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Trip updated successfully")),
//       );
//       Navigator.pop(context);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to update trip. Status: ${response.statusCode}")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Trip"),
//         backgroundColor: const Color.fromARGB(255, 101, 130, 105),
//         foregroundColor: Colors.white,
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 buildTextField("Trip Title", titleController),
//                 buildTextField("Description", descriptionController),
//                 buildTextField("Destination", destinationController),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => _pickDate(startDateController),
//                         child: buildTextField("Start Date", startDateController, enabled: false),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => _pickDate(endDateController),
//                         child: buildTextField("End Date", endDateController, enabled: false),
//                       ),
//                     ),
//                   ],
//                 ),
//                 buildTextField("Available Number", availableController, keyboardType: TextInputType.number),
//                 buildTextField("Price Per Person", priceController, keyboardType: TextInputType.number),
//                 buildTextField("Map Location", mapLocationController),
//                 const SizedBox(height: 12),
//                 DropdownButtonFormField<String>(
//                   value: selectedCategory,
//                   items: categories
//                       .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
//                       .toList(),
//                   onChanged: (val) {
//                     setState(() {
//                       selectedCategory = val!;
//                     });
//                   },
//                   decoration: const InputDecoration(
//                     labelText: 'Category',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 if (imageFile != null)
//                   Image.file(imageFile!, height: 200)
//                 else
//                   const Text("No image selected"),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton.icon(
//                       onPressed: () => pickImage(ImageSource.gallery),
//                       icon: const Icon(Icons.photo),
//                       label: const Text("From Gallery"),
//                     ),
//                     const SizedBox(width: 10),
//                     ElevatedButton.icon(
//                       onPressed: () => pickImage(ImageSource.camera),
//                       icon: const Icon(Icons.camera_alt),
//                       label: const Text("From Camera"),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Cancel"),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             sendUpdatedTripToServer();
//                           }
//                         },
//                         child: const Text("Save"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(String label, TextEditingController controller,
//       {TextInputType keyboardType = TextInputType.text, bool enabled = true}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         enabled: enabled,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return "Please enter $label";
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class EditTripPage extends StatefulWidget {
  final Map<String, dynamic> trip;

  const EditTripPage({super.key, required this.trip});

  @override
  State<EditTripPage> createState() => _EditTripPageState();
}

class _EditTripPageState extends State<EditTripPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController availableNumberController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController costController = TextEditingController();

  List<XFile> imageFiles = [];

  final String token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJtb2hhbWVkYXphbHk3NzJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiI4ZTA0OTA5NS01NzY4LTQyN2QtYWNmNy02NjU0ZGMxMmFlMGYiLCJqdGkiOiI4OWE2NzdkMS0yNzBjLTQ1YzItYmIzNC0zMTgwNmJkZTExNWIiLCJVc2VyVHlwZSI6Ik93bmVyIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiT3duZXIiLCJleHAiOjE3NDkwNzc3OTQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDY5NTAiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjU1NTU1In0.lFdnvnr1my2tGWfHQoUEzuNes5KL_KfkRY0HWHPSDgg";

  String? selectedCategory;
  final List<String> categories = [
    "Leisure Tourism",
    "Cultural & Historical Tourism",
    "Medical Tourism",
    "Adventure & Eco Tourism",
    "Shopping Tourism",
    "Religious Tourism",
    "Business & MICE Tourism",
  ];

  @override
  void initState() {
    super.initState();
    nameController.text = widget.trip['name'] ?? '';
    descriptionController.text = widget.trip['description'] ?? '';
    locationController.text = widget.trip['location'] ?? '';
    availableNumberController.text = widget.trip['availableNumber']?.toString() ?? '0';
    startDateController.text = widget.trip['startDate'] ?? '';
    endDateController.text = widget.trip['endDate'] ?? '';
    discountController.text = widget.trip['discount']?.toString() ?? '0';
    costController.text = widget.trip['cost']?.toString() ?? '0';
    selectedCategory = widget.trip['category'] ?? categories.first;
    // تحويل imageData إلى قائمة XFile إذا كانت موجودة (افتراض أنها روابط)
    if (widget.trip['imageData'] != null && (widget.trip['imageData'] as List).isNotEmpty) {
      // هنا نفترض أن imageData تحتوي على مسارات أو يمكن تحميلها كصور
      // يمكنك تعديل هذا الجزء حسب مصدر الصور
      imageFiles = (widget.trip['imageData'] as List).map((e) => XFile(e.toString())).toList();
    }
  }

  Future<void> pickMultipleImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages.isNotEmpty) {
      setState(() {
        imageFiles = pickedImages;
      });
    }
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(controller.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        controller.text = selectedDate.toIso8601String().split('T')[0];
      });
    }
  }

  Future<void> sendUpdatedTripToServer() async {
    final uri = Uri.parse('http://20.74.208.111:5260/api/Owners/AddDestinationWithImages');
    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = token;
    request.headers['accept'] = '*/*';

    request.fields['Name'] = nameController.text;
    request.fields['Description'] = descriptionController.text;
    request.fields['Location'] = locationController.text;
    request.fields['Category'] = selectedCategory ?? '';
    request.fields['AvilableNumber'] = availableNumberController.text;
    request.fields['StartDate'] = startDateController.text;
    request.fields['EndDate'] = endDateController.text; // تصحيح الاسم
    request.fields['Discount'] = discountController.text;
    request.fields['Cost'] = costController.text;

    for (var xfile in imageFiles) {
      if (await File(xfile.path).exists()) {
        final multipartFile = await http.MultipartFile.fromPath(
          'ImageData',
          xfile.path,
          contentType: MediaType('image', xfile.path.split('.').last),
        );
        request.files.add(multipartFile);
      }
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final updatedTrip = {
        'name': nameController.text,
        'description': descriptionController.text,
        'location': locationController.text,
        'category': selectedCategory,
        'availableNumber': int.tryParse(availableNumberController.text) ?? 0,
        'startDate': startDateController.text,
        'endDate': endDateController.text,
        'discount': double.tryParse(discountController.text) ?? 0.0,
        'cost': double.tryParse(costController.text) ?? 0.0,
        'imageData': imageFiles.map((e) => e.path).toList(),
      };

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Trip updated successfully")),
      );
      Navigator.pop(context, updatedTrip);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update trip. Status: ${response.statusCode}, Body: $responseBody")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Trip"),
        backgroundColor: const Color.fromARGB(255, 101, 130, 105),
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildTextField("Name", nameController),
                buildTextField("Description", descriptionController),
                buildTextField("Location", locationController),
                buildTextField("Available Number", availableNumberController,
                    keyboardType: TextInputType.number),
                buildTextField("Cost", costController,
                    keyboardType: TextInputType.number),
                buildTextField("Discount", discountController,
                    keyboardType: TextInputType.number),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _pickDate(startDateController),
                        child: buildTextField("Start Date", startDateController,
                            enabled: false),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _pickDate(endDateController),
                        child: buildTextField("End Date", endDateController,
                            enabled: false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Category:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  hint: const Text("Select a category"),
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Please select a category";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                if (imageFiles.isNotEmpty)
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageFiles.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.file(
                            File(imageFiles[index].path),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Text("Image not available"),
                          ),
                        );
                      },
                    ),
                  )
                else
                  const Text("No images selected"),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: pickMultipleImages,
                  icon: const Icon(Icons.image),
                  label: const Text("Select Multiple Images"),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            sendUpdatedTripToServer();
                          }
                        },
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          if (label == "Available Number" || label == "Cost" || label == "Discount") {
            if (double.tryParse(value) == null) {
              return "Please enter a valid number for $label";
            }
          }
          return null;
        },
      ),
    );
  }
}