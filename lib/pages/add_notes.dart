import 'package:flutter/material.dart';
import 'package:note_app_task/components/dropdown_users.dart';
import 'package:note_app_task/model/home_notes_model.dart';
import 'package:note_app_task/widget/text_field.dart';
import 'package:provider/provider.dart';

class AddNotes extends StatefulWidget {
  final String? textNote;
  final String? id;
  final String? userId;
  final bool? edite;
  const AddNotes({Key? key, this.textNote, this.id, this.userId, this.edite})
      : super(key: key);
  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final TextEditingController _note = TextEditingController();
  @override
  void initState() {
    _note.value = TextEditingValue(
        text: widget.textNote != null ? "${widget.textNote}" : ".");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoteModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.textNote != null ? "Edite Notes" : 'Add Notes'),
        actions: [
          IconButton(
              onPressed: widget.edite == true
                  ? () {
                      provider.updateNotes(
                          context: context,
                          id: widget.id,
                          textEdite: _note.text,
                          userID: widget.userId);
                    }
                  : () {
                      provider.addNotes(
                        context: context,
                        textAdd: _note.text,
                      );
                    },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _note,
              textAlign: TextAlign.start,
                          autofocus: false,
            enableInteractiveSelection: false,

              decoration: InputDecoration(
                filled: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                labelText: "name",
                hintText: "name",
                labelStyle: const TextStyle(
                  color: Color(0xffA0A0A0),
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              maxLines: 6,
            ),
            const SizedBox(
              height: 15,
            ),
            const DropdownUser()
          ],
        ),
      ),
    );
  }
}
