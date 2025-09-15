import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/services/navigation_service.dart';
import 'package:noteapp/theme.dart';
import 'package:noteapp/widgets/app_text_form_field.dart';

import '../models/note_model.dart';

class AddNoteBottomSheet {
  static Future<void> show(BuildContext context, Function(String, String) onSave, {Note? note}) {
    final titleController = TextEditingController(text: note?.title ?? "");
    final contentController = TextEditingController(text: note?.content ?? "");

    return showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.backgroundColor(context),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Add Note", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              AppTextFormField(controller: titleController, hintText: "Title"),
              const SizedBox(height: 12),
              AppTextFormField(controller: contentController, hintText: "Content", minLine: 4, maxLine: 10),

              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  final title = titleController.text.trim();
                  final content = contentController.text.trim();
                  if (title.isNotEmpty && content.isNotEmpty) {
                    onSave(title, content);
                    NavigationService.goBack();
                  }
                },
                icon: const Icon(Icons.save),
                label: Text("save".tr()),
              ),
            ],
          ),
        );
      },
    );
  }
}
