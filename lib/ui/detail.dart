
import 'package:flutter/material.dart';
import 'package:kontak_jitilab_dimasalamsyah_test/models/contact.dart';

class Detail extends StatefulWidget {

  final Contact contact;

  const Detail({super.key, required this.contact});

  @override
  _DetailState createState() => _DetailState();

}

class _DetailState extends State<Detail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.contact.avatar!),
                backgroundColor: Colors.transparent,
              ),
              Text("Name: ${widget.contact.name }"),
              Text("Phone: ${widget.contact.phone }"),
              Text("Gender: ${widget.contact.gender }"),
              Text("Email: ${widget.contact.email }"),
            ],
          ),
        ),
      ),
    );
  }

}