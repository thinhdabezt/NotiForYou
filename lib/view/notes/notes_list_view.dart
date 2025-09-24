import 'package:flutter/material.dart';
import 'package:notiforyou/constants/eight_bit_theme.dart';
import 'package:notiforyou/services/crud/notes_service.dart';
import 'package:notiforyou/utilities/dialogs/delete_dialog.dart';
import 'package:notiforyou/view/widgets/pixel_widgets.dart';

typedef NoteCallBack = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final NoteCallBack onDeleteNote;
  final NoteCallBack onTap;

  const NotesListView({
    Key? key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Header with note count
          PixelContainer(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Text(
                  "♦ NOTES LOG ♦",
                  style: EightBitTheme.headingStyle.copyWith(
                    color: EightBitTheme.accentText,
                  ),
                ),
                const Spacer(),
                Text(
                  "COUNT: ${notes.length}",
                  style: EightBitTheme.bodyStyle.copyWith(
                    color: EightBitTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          
          // Notes list
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: PixelListTile(
                    title: Text(
                      note.text.isEmpty ? "[EMPTY NOTE]" : note.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: EightBitTheme.bodyStyle.copyWith(
                        color: note.text.isEmpty 
                            ? EightBitTheme.secondaryText.withOpacity(0.6)
                            : EightBitTheme.primaryText,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: EightBitTheme.tertiaryBackground,
                              border: Border.all(
                                color: EightBitTheme.borderColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "NOTE #${note.id}",
                              style: EightBitTheme.bodyStyle.copyWith(
                                fontSize: 12,
                                color: EightBitTheme.primaryText,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${note.text.length} chars",
                            style: EightBitTheme.bodyStyle.copyWith(
                              fontSize: 12,
                              color: EightBitTheme.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: EightBitTheme.pixelButtonDecoration(
                        backgroundColor: EightBitTheme.tertiaryBackground,
                        borderColor: EightBitTheme.secondaryText,
                      ),
                      child: Icon(
                        Icons.note,
                        color: EightBitTheme.primaryText,
                        size: 20,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PixelIconButton(
                          icon: Icons.edit,
                          onPressed: () => onTap(note),
                          color: EightBitTheme.secondaryText,
                          tooltip: "Edit Note",
                        ),
                        const SizedBox(width: 8),
                        PixelIconButton(
                          icon: Icons.delete_outline,
                          onPressed: () async {
                            final shouldDelete = await showDeleteDialog(context);
                            if (shouldDelete) {
                              onDeleteNote(note);
                            }
                          },
                          color: EightBitTheme.errorText,
                          tooltip: "Delete Note",
                        ),
                      ],
                    ),
                    onTap: () => onTap(note),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                );
              },
            ),
          ),
          
          // Footer with instructions
          PixelContainer(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: const EdgeInsets.only(top: 16),
            backgroundColor: EightBitTheme.tertiaryBackground,
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: EightBitTheme.secondaryText,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "TAP TO EDIT • SWIPE FOR OPTIONS",
                    style: EightBitTheme.bodyStyle.copyWith(
                      fontSize: 12,
                      color: EightBitTheme.secondaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}