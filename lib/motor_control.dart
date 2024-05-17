import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  final _urlController1 = TextEditingController();
  final _urlController2 = TextEditingController();
  final _urlController3 = TextEditingController();
  final _postUrlController = TextEditingController();
  final _postBodyController = TextEditingController();
  String _response = '';

  void _sendGetRequests() async {
    final responses = await Future.wait([
      http.get(Uri.parse(_urlController1.text)),
      http.get(Uri.parse(_urlController2.text)),
      http.get(Uri.parse(_urlController3.text)),
    ]);

    setState(() {
      _response = responses.map((response) => response.body).join('\n');
    });
  }

  void _sendPostRequest() async {
    final url = _postUrlController.text;
    final body = _postBodyController.text;
    final response = await http.post(Uri.parse(url), body: body);

    setState(() {
      _response = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 61, 59, 59), // Set background color to a darker shade of black
      appBar: AppBar(
        title: Text('API Page'),
        backgroundColor: Colors.green, // Set app bar color to green
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Motor 1 URL input field
              TextFormField(
                controller: _urlController1,
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'Motor 1 URL',
                  labelStyle: TextStyle(
                      color: Colors.white), // Set label text color to white
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Set border color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Set border color to white
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Motor 2 URL input field
              TextFormField(
                controller: _urlController2,
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'Motor 2 URL',
                  labelStyle: TextStyle(
                      color: Colors.white), // Set label text color to white
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Set border color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Set border color to white
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Motor 3 URL input field
              TextFormField(
                controller: _urlController3,
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'Motor 3 URL',
                  labelStyle: TextStyle(
                      color: Colors.white), // Set label text color to white
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Set border color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Set border color to white
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Send GET requests button
              ElevatedButton(
                onPressed: () {
                  _sendGetRequests();
                },
                child: Text('Send GET Requests'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Set button color to green
                ),
              ),
              SizedBox(height: 16.0),
              // POST URL input field
              TextFormField(
                controller: _postUrlController,
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'POST URL',
                  labelStyle: TextStyle(
                      color: Colors.white), // Set label text color to white
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Set border color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Set border color to white
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // POST body input field
              TextFormField(
                controller: _postBodyController,
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'POST Body',
                  labelStyle: TextStyle(
                      color: Colors.white), // Set label text color to white
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Set border color to white
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Set border color to white
                  ),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 16.0),
              // Send POST request button
              ElevatedButton(
                onPressed: () {
                  _sendPostRequest();
                },
                child: Text('Send POST Request'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Set button color to green
                ),
              ),
              SizedBox(height: 16.0),
              // Response display
              Text(
                _response,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white), // Set text color to white
              ),
            ],
          ),
        ),
      ),
    );
  }
}
