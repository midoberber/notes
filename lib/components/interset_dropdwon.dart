import 'package:flutter/material.dart';
import 'package:note_app_task/json/interest_json.dart';
import 'package:note_app_task/model/home_notes_model.dart';
import 'package:note_app_task/model/user_model.dart';
import 'package:provider/provider.dart';

class IntersetDropdwon extends StatelessWidget {
  const IntersetDropdwon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (BuildContext context, userModel, Widget? child) =>
          FutureBuilder<List<Interest>>(
              future: userModel.loadInterest(context),
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
                        value: userModel.getvalueInterst,
                        isDense: true,
                        onChanged: (val) {
                          userModel.setvalueInterst(val.toString());
                        },
                        items: snapshot.data!.map((value) {
                          // productProvider.setbrandValueString(value.name);
                          return DropdownMenuItem(
                            onTap: () {
                              userModel.setvalueInterst(value.id.toString());
                            },
                            value: value.id,
                            child: Text(
                              "${value.intrestText}",
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
