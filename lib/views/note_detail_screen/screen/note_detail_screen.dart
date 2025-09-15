import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/blocs/note_bloc/note_bloc.dart';
import 'package:noteapp/services/navigation_service.dart';
import 'package:noteapp/theme.dart';
import 'package:noteapp/widgets/add_note_bottom_sheet.dart';
import 'package:noteapp/widgets/app_button.dart';

import '../../../models/note_model.dart';

class NoteDetailScreen extends StatelessWidget {
  final Function() delete;
  final Note note;

  const NoteDetailScreen({super.key, required this.note, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: AppTheme.backgroundColor(context),
        child: Row(
          children: [
            Expanded(flex: 2, child: AppButton(title: "update".tr(),onTap: (){
              AddNoteBottomSheet.show(context, (title,content){
                NavigationService.goBack();
                Note note=this.note.copyWith(title: title,content: content,createdAt: this.note.createdAt,userId: this.note.userId,id: this.note.id);
               context.read<NoteBloc>().add(EditNote(note: note));
              },note: note);
            },)),
            SizedBox(width: appPadding),
            Expanded(
              child: AppButton(
                delete: true,
                title: "delete".tr(),
                onTap: () {
                  NavigationService.goBack();
                  delete();
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppTheme.backgroundColor(context),
      appBar: AppBar(backgroundColor: AppTheme.fillColor(context), title: Text("noteDetails".tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: appPadding),
            if (note.createdAt != null) Text(DateFormat("dd/MM/yyyy").format(note.createdAt!), style: TextStyle(color: AppTheme.hintColor(context), fontSize: 14)),
            const SizedBox(height: appPadding),
            Expanded(
              child: SingleChildScrollView(child: Text(note.content, style: const TextStyle(fontSize: 16, height: 1.4))),
            ),
          ],
        ),
      ),
    );
  }
}
