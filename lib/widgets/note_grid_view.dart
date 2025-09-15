import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/note_bloc/note_bloc.dart';
import '../models/note_model.dart';
import '../services/navigation_service.dart';
import '../theme.dart';
import '../views/note_detail_screen/screen/note_detail_screen.dart';
import 'add_note_bottom_sheet.dart';
import 'delete_snackbar.dart';

class NoteGridView extends StatefulWidget {
  final List<Note> notes;

  const NoteGridView({super.key, required this.notes});

  @override
  State<NoteGridView> createState() => _NoteGridViewState();
}

class _NoteGridViewState extends State<NoteGridView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final noteState = context.read<NoteBloc>().state;

      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && noteState is NoteLoaded && noteState.isMore == true && noteState.isLoading == false) {
        context.read<NoteBloc>().add(LoadNotes(nextToken: widget.notes.last.id, isMore: true));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(appPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: appPadding, mainAxisSpacing: appPadding, childAspectRatio: 3 / 4),
      itemCount: widget.notes.length,
      itemBuilder: (context, index) {
        final data = widget.notes[index];

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(appPadding)),
          elevation: 2,
          shadowColor: AppTheme.shadowColor(context),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: () {
              NavigationService.push(
                NoteDetailScreen(
                  note: data,
                  delete: () {
                    context.read<NoteBloc>().add(RemoveNote(data.id!));

                    showSnackBar(context);
                  },
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(appPadding),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            data.content,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, color: AppTheme.titleTextColor(context)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(data.createdAt != null ? DateFormat("dd/MM/yyyy").format(data.createdAt!) : "", style: TextStyle(fontSize: 12, color: AppTheme.hintColor(context))),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      AddNoteBottomSheet.show(context, (title,content){
                        Note note=data.copyWith(title: title,content: content,createdAt: data.createdAt,userId: data.userId,id: data.id);
                        context.read<NoteBloc>().add(EditNote(note: note));
                      },note: data);
                    } else if (value == 'delete') {
                      context.read<NoteBloc>().add(RemoveNote(data.id!));

                      showSnackBar(context);
                    }
                  },
                  itemBuilder: (context) => [
                     PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18),
                          SizedBox(width: 8),
                          Text("update".tr()),
                        ],
                      ),
                    ),
                     PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 18),
                          SizedBox(width: 8),
                          Text("delete".tr()),
                        ],
                      ),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
