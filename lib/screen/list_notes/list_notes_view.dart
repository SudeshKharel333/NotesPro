import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'list_notes_logic.dart';

class ListUsersPage extends StatelessWidget {
  const ListUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListNotesLogic>(
      init: ListNotesLogic(), // Ensure controller is initialized
      builder: (logic) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(children: [
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
              logic.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        value: null,
                        color: Colors.red,
                      ),
                    )
                  : (logic.notes.isEmpty)
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "No notes available",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                      : ListView.builder(
                          itemCount: logic.notes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 4.0),
                              child: Card(
                                color: const Color.fromARGB(221, 62, 51, 51),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Spacer(),
                                                  GestureDetector(
                                                      onTap: () {
                                                        logic.deleteNote(
                                                            logic.notes[index]);
                                                      },
                                                      child: Icon(
                                                          Icons.delete_forever))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                " ${logic.notes[index].title}",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                " ${logic.notes[index].content}",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ]));
      },
    );
  }
}
