import 'package:flutter/material.dart';
import 'package:note_app_task/json/note_home_json.dart';
import 'package:note_app_task/model/home_notes_model.dart';
import 'package:note_app_task/pages/add_notes.dart';
import 'package:note_app_task/pages/add_user.dart';
import 'package:provider/provider.dart';

class HomeNote extends StatefulWidget {
  const HomeNote({Key? key}) : super(key: key);

  @override
  State<HomeNote> createState() => _HomeNoteState();
}

class _HomeNoteState extends State<HomeNote> {
  @override
  Widget build(BuildContext context) {
    final noteModel = Provider.of<NoteModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddUser()));
            },
            icon: const Icon(Icons.person_add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () async{
             await noteModel.deletNote(context: context);
              setState(() {
                
              });
            },
            icon: const Icon(Icons.clear_all),
          ),
        ],
      ),
      body: FutureBuilder<List<Notes>>(
          future: noteModel.loadNotes(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("${snapshot.error}"),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == null) {
              return const Center(
                child: Text("No Data"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list),
                    ),

                    // when rebuild the cost widget donot rebuild
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          Notes note = snapshot.data![i];
                          return ListTile(
                            title: Text("${note.text}"),
                            trailing: IconButton(
                              onPressed: () async{
                              var x = await  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddNotes(
                                              textNote: note.text,
                                              id: note.id,
                                              userId: note.userId,
                                              edite: true,
                                            )));
                                note.userId != null
                                    ? noteModel
                                        .setvalueDropdon(note.userId.toString())
                                    : null;
                                    setState(() {
                                      
                                    });
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          );
                        }))
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
var x = await  Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNotes(
                        edite: false,
                      )));
                      setState(() {
                        
                      });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
