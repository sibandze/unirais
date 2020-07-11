import "package:flutter/material.dart";

class ComingSoonPage extends StatefulWidget {
  @override
  _ComingSoonState createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coming Soon"),
      ),
      body: Text("This page is coming soon"),
    );
  }
}
