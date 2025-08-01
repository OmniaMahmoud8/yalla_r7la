// Screens/PersonalInformation_Admin_Page.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yalla_r7la_new/Screens/Edit_Admin_InformationPage.dart';

class PersonalInformation_Admin_Page extends StatelessWidget {
  final String email;
  final String phone;
  final String birthDate;
  final String gender;
  final String? imagePath;
  final String firstName;
  final String lastName;
  final String userName;

  const PersonalInformation_Admin_Page({
    super.key,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    this.imagePath,
    required this.firstName,
    required this.lastName,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 221, 192),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Personal Information',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: imagePath != null
                        ? FileImage(File(imagePath!))
                        : null,
                    child: imagePath == null
                        ? const Icon(
                            Icons.person,
                            size: 70,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Edit_Admin_InformationPage(
                              email: email,
                              phone: phone,
                              birthDate: birthDate,
                              gender: gender,
                              profilePicture: '',
                              name: '$firstName $lastName',
                            ),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 101, 130, 105),
                        radius: 20,
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildInfoRow("First Name", firstName),
            const SizedBox(height: 10),
            _buildInfoRow("Last Name", lastName),
            const SizedBox(height: 10),
            _buildInfoRow("Username", userName),
            const SizedBox(height: 10),
            _buildInfoRow("Email", email),
            const SizedBox(height: 10),
            _buildInfoRow("Phone", phone),
            const SizedBox(height: 10),
            _buildInfoRow("Birth Date", birthDate),
            const SizedBox(height: 10),
            _buildInfoRow("Gender", gender),
            const SizedBox(height: 10),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
