import 'package:dark_admin/bookings_screen.dart';
import 'package:flutter/material.dart';
import 'upload_screen.dart';
import 'manage_items_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية ناعمة
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Welcome Admin!",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDashboardButton(
              context,
              label: "Add Trip",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UploadScreen(type: "trips"),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildDashboardButton(
              context,
              label: "Add Place",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UploadScreen(type: "places"),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildDashboardButton(
              context,
              label: "Manage Trips",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ManageItemsScreen(type: "trips"),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildDashboardButton(
              context,
              label: "Manage Places",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ManageItemsScreen(type: "places"),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildDashboardButton(
              context,
              label: "Booking Details",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardButton(BuildContext context,
      {required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF004C77), // لون زر consistent
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onPressed: onPressed,
    );
  }
}
