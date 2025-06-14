// pages/HomePage.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yalla_r7la_new/core/service/api_service.dart';
import 'package:yalla_r7la_new/core/service/url_manager.dart';
import 'package:yalla_r7la_new/models/get_destination/get_destination.dart';
import 'package:yalla_r7la_new/pages/AddCardPage.dart';
import 'package:yalla_r7la_new/pages/CardDetailsPage.dart';
import 'package:yalla_r7la_new/pages/NewTripPage.dart';
import 'package:yalla_r7la_new/pages/PaymentChartPage.dart';
import 'package:yalla_r7la_new/pages/PaymentHistoryPage.dart';
import 'package:yalla_r7la_new/pages/TripChartPage.dart';
import 'package:yalla_r7la_new/pages/TripDetailsPage.dart';
import 'package:yalla_r7la_new/pages/Chat_AI_Page.dart';
import 'package:yalla_r7la_new/pages/profile_page.dart';
import 'package:yalla_r7la_new/pages/error404page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<GetDestination> trips = [];
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJtb2hhbWVkYXphbHk3NzJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJjODdjMDU5OS0zNGIxLTQ4NTEtYTdlMy1kYTYyNWEwYzEwODQiLCJqdGkiOiI1MjBiMmI3My1mNDY2LTQ4ZjYtYTJmYi05MGJjZTJmZWQ3ZjkiLCJVc2VyVHlwZSI6Ik93bmVyIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiT3duZXIiLCJleHAiOjE3NDk5OTY5MDYsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDY5NTAiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjU1NTU1In0.nnJ11TzOSCft_Kzw6rCxEZlSc7kA5-OPHZqaxifrX44";
  @override
  void initState() {
    getTripsFromServer();
    super.initState();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ChatPage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfilePage(email: '', fullName: ''),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Error404page()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PaymentChartPage()),
      );
    }
  }

  void _navigateToAddTrip() async {
    // final result =
    await Navigator.push<dynamic>(
      context,
      MaterialPageRoute(builder: (_) => const NewTripPage()),
    );

    // if (result != null) {
    //   setState(() {
    //     if (result is Map<String, dynamic>) {
    //       trips.add(result);
    //     }
    //   });
    // }
  }

  void _navigateToTripDetails(int index) async {
    // final result =
    await Navigator.push<GetDestination>(
      context,
      MaterialPageRoute(
        builder: (context) => TripDetailsPage(trip: trips[index]),
      ),
    );

    // if (result != null) {
    //   setState(() {
    //     if (result == 'delete') {
    //       trips.removeAt(index);
    //     } else if (result is Map<String, dynamic>) {
    //       final tripId = result.destinationId;
    //       final tripIndex = trips.indexWhere(
    //         (trip) => trip.destinationId == tripId,
    //       );
    //       if (tripIndex != -1) {
    //         trips[tripIndex] = result;
    //       } else {
    //         trips.add(result);
    //       }
    //     }
    //   });
    // }
  }

  Future<void> getTripsFromServer() async {
    await ApiService(dio: Dio())
        .getWithToken(
          endPoint: UrlManager().getDestinationWithImages,
          token: token,
        )
        .then((r) {
          log(r.toString());
          trips = (r.data as List<dynamic>)
              .map((item) => GetDestination.fromJson(item))
              .toList();
          setState(() {});
        });
    // GetDestination.fromJson(getTrips as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 221, 192),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 207, 221, 192),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox.shrink(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilePage(email: '', fullName: ''),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Payment'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddCardPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Payment History'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PaymentHistoryPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Cards'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CardDetailsPage(userCards: []),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text('Payment Chart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentChartPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Trips Chart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TripChartPage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Hi! You want to add new items?",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 101, 130, 105),
        elevation: 6,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: _navigateToAddTrip,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 101, 130, 105),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            child: const Text(
              "Add",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              color: const Color.fromARGB(255, 101, 130, 105),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "ALL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "History",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Medical",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Adventure",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: trips.isEmpty
                  ? const Center(child: Text("No trips yet. Add a new one!"))
                  : ListView.builder(
                      itemCount: trips.length,
                      itemBuilder: (context, index) {
                        final trip = trips[index];
                        final List<String> imageData = trip.images != null
                            ? trip.images!
                                  .map((e) => e.imagePath ?? '')
                                  .toList()
                            : [];
                        return GestureDetector(
                          onTap: () => _navigateToTripDetails(index),
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            color: Colors.white,
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (imageData.isNotEmpty)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        imageData[0],
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Text(
                                                  "Image not available",
                                                ),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          trip.name ?? 'No Title',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              101,
                                              130,
                                              105,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          trip.location ?? 'No Location',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Cost: ${trip.cost?.toString() ?? '0.0'} EGP',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        selectedItemColor: const Color.fromARGB(255, 101, 130, 105),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color.fromARGB(255, 101, 130, 105),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Payment",
          ),
        ],
      ),
    );
  }
}
