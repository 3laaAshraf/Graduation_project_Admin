import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 194, 255),
      appBar: AppBar(
        title: const Text(
          "All Bookings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.black,
            fontFamily: 'R',
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 173, 176, 247),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading bookings"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final bookings = snapshot.data!.docs;

          if (bookings.isEmpty) {
            return const Center(child: Text("No bookings found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final data = bookings[index].data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 26, 9, 68),
                        Color.fromARGB(255, 86, 43, 126)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: AutoSizeText(
                            data['placeName'] ?? '',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF34A853),
                              fontFamily: 'C',
                            ),
                            textAlign: TextAlign.center,
                            maxFontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Divider(height: 15),
                        const SizedBox(height: 2),
                        buildRow(Icons.person, data['name'] ?? ''),
                        buildRow(Icons.email, data['email'] ?? ''),
                        buildRow(Icons.phone, data['number'] ?? ''),
                        buildRow(Icons.date_range, data['bookDate'] ?? ''),
                        buildRow(
                            Icons.monetization_on, "${data['amount'] ?? ''}\$"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Widget buildRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 14),
        Expanded(
          child: AutoSizeText(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'S',
            ),
            maxLines: 1,
            minFontSize: 8, // Shrinks if needed
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
