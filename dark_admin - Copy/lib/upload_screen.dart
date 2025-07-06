import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadScreen extends StatefulWidget {
  final String type;
  final Map<String, dynamic>? editData;
  final String? docId;

  const UploadScreen(
      {super.key, required this.type, this.editData, this.docId});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController imageUrl = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController included = TextEditingController();
  final TextEditingController itinerary = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.editData != null) {
      imageUrl.text = widget.editData!["imageUrl"] ?? '';
      title.text = widget.editData!["title"] ?? '';
      price.text = widget.editData!["price"] ?? '';
      description.text = widget.editData!["description"] ?? '';
      included.text = widget.editData!["included"] ?? '';
      itinerary.text = widget.editData!["itinerary"] ?? '';
    }
  }

  Future<void> uploadData() async {
    if (_formKey.currentState!.validate()) {
      final doc = {
        "imageUrl": imageUrl.text,
        "title": title.text,
        "price": price.text,
        "description": description.text,
        "included": included.text,
        "itinerary": itinerary.text,
        "rating":
            widget.editData != null ? widget.editData!["rating"] ?? [] : [],
      };

      if (widget.editData == null) {
        await FirebaseFirestore.instance.collection(widget.type).add(doc);
      } else {
        await FirebaseFirestore.instance
            .collection(widget.type)
            .doc(widget.docId)
            .update(doc);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${widget.type} saved!")),
        );
      }
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black87),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.grey[100],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.editData != null
              ? "Edit ${widget.type}"
              : "Upload ${widget.type}",
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: imageUrl,
                decoration: _inputDecoration(
                  "Image URL",
                ),
                style: TextStyle(
                  color: Colors.black, // 👈 Change this to any color you want
                  fontSize: 16, // Optional: change font size
                ),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: title,
                decoration: _inputDecoration("Title"),
                style: TextStyle(
                  color: Colors.black, // 👈 Change this to any color you want
                  fontSize: 16, // Optional: change font size
                ),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: price,
                decoration: _inputDecoration("Price"),
                style: TextStyle(
                  color: Colors.black, // 👈 Change this to any color you want
                  fontSize: 16, // Optional: change font size
                ),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: description,
                decoration: _inputDecoration("Description"),
                style: TextStyle(
                  color: Colors.black, // 👈 Change this to any color you want
                  fontSize: 16, // Optional: change font size
                ),
                validator: (v) => v!.isEmpty ? "Required" : null,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: included,
                decoration: _inputDecoration("Included"),
                style: TextStyle(
                  color: Colors.black, // 👈 Change this to any color you want
                  fontSize: 16, // Optional: change font size
                ),
                validator: (v) => v!.isEmpty ? "Required" : null,
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: itinerary,
                decoration: _inputDecoration("Itinerary"),
                style: TextStyle(
                  color: Colors.black, // 👈 Change this to any color you want
                  fontSize: 16, // Optional: change font size
                ),
                validator: (v) => v!.isEmpty ? "Required" : null,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004C77),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: uploadData,
                child: Text(
                  widget.editData != null ? "Update" : "Upload",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
