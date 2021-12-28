import 'package:flutter/material.dart';
import 'package:note_app_task/json/user_json.dart';
import 'package:note_app_task/model/home_notes_model.dart';
import 'package:note_app_task/model/user_model.dart';
import 'package:provider/provider.dart';

class DropdownUser extends StatelessWidget {
  const DropdownUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserModel>(context, listen: false);

    return Consumer<NoteModel>(
      builder: (BuildContext context, noteModel, Widget? child) =>
          FutureBuilder<List<User>>(
              future: noteModel.loadUser(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
                return FormField(builder: (FormFieldState state) {
                  return InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        labelText: "name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      // isEmpty: _value == null || _value == '',
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        value: noteModel.getvalueDropdon,
                        isDense: true,
                        onChanged: (val) {
                          noteModel.setvalueDropdon(val.toString());
                        },
                        items: snapshot.data!.map((value) {
                          // productProvider.setbrandValueString(value.name);
                          return DropdownMenuItem(
                            onTap: () {
                              noteModel.setvalueDropdon(value.id.toString());
                            },
                            value: value.id,
                            child: Text(
                              "${value.username}",
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      )));
                });
              }),
    );
  }
}
