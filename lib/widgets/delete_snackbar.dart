import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/note_bloc/note_bloc.dart';

void showSnackBar(BuildContext context)  {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:  Text("noteDeleted".tr()),
      duration: const Duration(seconds: 30),
      action: SnackBarAction(
        label: "cancel".tr(),
        onPressed: () {
          context.read<NoteBloc>().add(UndoRemoveNote());
        },
      ),
    ),
  );
}
