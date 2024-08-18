import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notespro/screen/homescreen/homescreen_logic.dart';
import 'package:notespro/screen/list_notes/list_notes_view.dart';

class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenLogic>(builder: (logic) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'NotesPro',
            style: TextStyle(
              color: Colors.white, // Set text color for the AppBar title
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ), // First action icon
              onPressed: () {
                // Handle the search icon press
                print("Search icon pressed");
              },
            ),
            IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ), // Second action icon
              onPressed: () {
                // Handle the more icon press
                print("More icon pressed");
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/notes.png'), // Path to your background image
                  fit: BoxFit
                      .none, // Adjust the image to cover the entire background
                ),
              ),
            ),
            ListUsersPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Open full-screen editor when the button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FullScreenEditor()),
            );
          },
          backgroundColor: Color.fromARGB(221, 62, 51, 51),
          child: Icon(Icons.add, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28), // Ensures it's a circle
          ),
        ),
      );
    });
  }
}

class FullScreenEditor extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenLogic>(builder: (logic) {
      return Scaffold(
        backgroundColor: Colors.black, // Full screen black background
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.white), // Change back button color
            onPressed: () {
              Navigator.pop(context); // Close the editor and go back
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save, color: Colors.white),
              onPressed: () {
                logic.createNote();
                // Handle saving the note
                print("Note saved");
                Navigator.pop(context); // Close the editor after saving
              },
            ),
          ],
        ),
        body: Column(
          children: [
            TextField(
              controller: logic.titleController,
              decoration: InputDecoration(
                hintText: 'Enter title here',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.black, // Make TextField background black
                border: InputBorder.none, // Remove border
              ),
              style: TextStyle(color: Colors.white), // Set text color to white
            ),
            SizedBox(height: 16), // Space between title and content fields
            Expanded(
              child: TextField(
                controller: logic.contentController,
                decoration: InputDecoration(
                  hintText: 'Enter content here',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.black, // Make TextField background black
                  border: InputBorder.none, // Remove border
                ),
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                maxLines: null, // Expands TextField vertically
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      );
    });
  }
}
