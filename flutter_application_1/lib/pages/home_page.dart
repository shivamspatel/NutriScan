import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:hack_mt_test/services/data_service.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataService _dataService = DataService();
  Map<String, dynamic>? _data;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await _dataService.fetchData();
      setState(() {
        _data = data;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }


@override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_data != null)
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User ID: ${_data!['userId']}',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text('ID: ${_data!['id']}',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text('Title: ${_data!['title']}',
                            style: Theme.of(context).textTheme.headlineSmall),
                        Text('Completed: ${_data!['completed']}',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                )
              else
                const CircularProgressIndicator(),
              const SizedBox(height: 20),
              if (_image != null)
                 ClipRRect(
                     borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                      _image!,
                        width: 200,
                      ),
                  ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Open Camera'),
              ),
             const SizedBox(height: 20),
             ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/details',
                        arguments: 'Hello from Home!');
                  },
                  child: const Text('Go to Details'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}