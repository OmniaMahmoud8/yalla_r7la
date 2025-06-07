// pages/TripDetailsPage.dart

// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
// import 'EditTripPage.dart';
// import 'Transaction.dart';

// class TripDetailsPage extends StatelessWidget {
//   final Map<String, dynamic> trip;

//   const TripDetailsPage({super.key, required this.trip});

//   @override
//   Widget build(BuildContext context) {
//     final String name = trip['name'] ?? 'No Name';
//     final String description = trip['description'] ?? 'No Description';
//     final String location = trip['location'] ?? 'No Location';
//     final String category = trip['category'] ?? 'No Category';
//     final int availableNumber = trip['availableNumber'] ?? 0;
//     final String startDate = trip['startDate'] ?? 'No Start Date';
//     final String endDate = trip['endDate'] ?? 'No End Date';
//     final double discount = (trip['discount'] ?? 0).toDouble();
//     final double cost = (trip['cost'] ?? 0).toDouble();
//     final List<String> imageData = trip['imageData'] != null
//         ? List<String>.from(trip['imageData'])
//         : [];

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 207, 221, 192),
//       appBar: AppBar(
//         title: const Text(
//           "Trip Details",
//           style: TextStyle(color: Color.fromARGB(255, 236, 237, 238)),
//         ),
//         backgroundColor: const Color.fromARGB(255, 101, 130, 105),
//         elevation: 0,
//         centerTitle: true,
//         iconTheme: const IconThemeData(
//           color: Color.fromARGB(255, 207, 221, 192),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () async {
//               final updatedTrip = await Navigator.push<Map<String, dynamic>>(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => EditTripPage(trip: trip),
//                 ),
//               );
//               if (updatedTrip != null) {
//                 Navigator.pop(context, updatedTrip);
//               }
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.share),
//             onPressed: () {
//               Share.share("Trip to $location\nFrom $startDate to $endDate");
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.red),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (ctx) => AlertDialog(
//                   title: const Text("Confirm Delete"),
//                   content:
//                       const Text("Are you sure you want to delete this trip?"),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(ctx),
//                       child: const Text("Cancel"),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(ctx);
//                         Navigator.pop(context, 'delete');
//                       },
//                       child: const Text(
//                         "Delete",
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           if (imageData.isNotEmpty)
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.network(
//                 imageData[0],
//                 height: 200,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           const SizedBox(height: 20),
//           Text(
//             name,
//             style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               const Icon(Icons.location_on, size: 20),
//               const SizedBox(width: 5),
//               Text(
//                 location,
//                 style: const TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             description,
//             style: const TextStyle(fontSize: 16),
//           ),
//           const Divider(height: 30),
//           _buildDetailRow("Category", category),
//           _buildDetailRow("Available Seats", availableNumber.toString()),
//           _buildDetailRow("Start Date", startDate),
//           _buildDetailRow("End Date", endDate),
//           _buildDetailRow("Cost", "$cost EGP"),
//           _buildDetailRow("Discount", "$discount%"),
//           const SizedBox(height: 80), // Space before button
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: const Color.fromARGB(255, 101, 130, 105),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const TransactionsPage(),
//             ),
//           );
//         },
//         icon: const Icon(
//           Icons.list_alt,
//           color: Color.fromARGB(255, 207, 221, 192),
//         ),
//         label: const Text(
//           "Transactions",
//           style: TextStyle(color: Color.fromARGB(255, 207, 221, 192)),
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Text(
//             "$title: ",
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'EditTripPage.dart';
import 'Transaction.dart';

class TripDetailsPage extends StatelessWidget {
  final Map<String, dynamic> trip;

  const TripDetailsPage({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final String name = trip['name'] ?? 'No Name';
    final String description = trip['description'] ?? 'No Description';
    final String location = trip['location'] ?? 'No Location';
    final String category = trip['category'] ?? 'No Category';
    final int availableNumber = trip['availableNumber'] ?? 0;
    final String startDate = trip['startDate'] ?? 'No Start Date';
    final String endDate = trip['endDate'] ?? 'No End Date';
    final double discount = (trip['discount'] ?? 0).toDouble();
    final double cost = (trip['cost'] ?? 0).toDouble();
    final List<String> imageData = trip['imageData'] != null
        ? List<String>.from(trip['imageData'])
        : [];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 221, 192),
      appBar: AppBar(
        title: const Text(
          "Trip Details",
          style: TextStyle(color: Color.fromARGB(255, 236, 237, 238)),
        ),
        backgroundColor: const Color.fromARGB(255, 101, 130, 105),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 207, 221, 192),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedTrip = await Navigator.push<Map<String, dynamic>>(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTripPage(trip: trip),
                ),
              );
              if (updatedTrip != null) {
                Navigator.pop(context, updatedTrip);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share("Trip to $location\nFrom $startDate to $endDate");
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Confirm Delete"),
                  content:
                      const Text("Are you sure you want to delete this trip?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pop(context, 'delete');
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section for all images
          if (imageData.isNotEmpty)
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageData[index],
                        height: 200,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 20),
          // Trip details section
          Text(
            name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 101, 130, 105),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on, size: 20, color: Colors.grey),
              const SizedBox(width: 5),
              Text(
                location,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 15),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(height: 15),
          _buildDetailRow("Category", category),
          _buildDetailRow("Available Seats", availableNumber.toString()),
          _buildDetailRow("Start Date", startDate),
          _buildDetailRow("End Date", endDate),
          _buildDetailRow("Cost", "$cost EGP"),
          _buildDetailRow("Discount", "$discount%"),
          const SizedBox(height: 80), // Space before button
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 101, 130, 105),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TransactionsPage(),
            ),
          );
        },
        icon: const Icon(
          Icons.list_alt,
          color: Color.fromARGB(255, 207, 221, 192),
        ),
        label: const Text(
          "Transactions",
          style: TextStyle(color: Color.fromARGB(255, 207, 221, 192)),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color.fromARGB(255, 101, 130, 105),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}