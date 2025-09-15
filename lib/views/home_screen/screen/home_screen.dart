import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/blocs/note_bloc/note_bloc.dart';
import 'package:noteapp/models/note_model.dart';
import 'package:noteapp/theme.dart';
import 'package:noteapp/widgets/search_text_field.dart';

import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../widgets/add_note_bottom_sheet.dart';
import '../../../widgets/note_grid_view.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
 final TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    NoteState noteState = context.read<NoteBloc>().state;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddNoteBottomSheet.show(context, (title, content) {
            context.read<NoteBloc>().add(
              AddNote(
                note: Note(title: title, content: content),
              ),
            );
          });
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: AppTheme.backgroundColor(context),
      appBar: AppBar(
        centerTitle: true,
        title: Text("home".tr()),
        actions: [PopupMenuButton<String>(
          icon: const Icon(Icons.account_circle),
          onSelected: (value) {
            if (value == 'logout') {
              context.read<AuthBloc>().add(SignOutRequested());

            }
          },
          itemBuilder: (context) => [

            PopupMenuItem(
              value: 'logout',
              child: Row(
                children:  [
                  Icon(Icons.logout, color: AppTheme.deleteColor(context)),
                  SizedBox(width: 8),
                  Text("logout".tr()),
                ],
              ),
            ),
          ],
        ),],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(appPadding),
            child: SearchTextField(
              onChange: (value) {
                context.read<NoteBloc>().add(LoadNotes(search: value,isMore: false));
              },
            ),
          ),
          if (noteState is NoteLoaded) Expanded(child: NoteGridView(notes: noteState.notes,)) else if (noteState is NoteLoading) Expanded(child: Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}
