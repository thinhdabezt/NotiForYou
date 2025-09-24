import 'package:flutter/material.dart';
import 'package:notiforyou/constants/routes.dart';
import 'package:notiforyou/constants/eight_bit_theme.dart';
import 'package:notiforyou/enums/menu_action.dart';
import 'package:notiforyou/services/auth/auth_service.dart';
import 'package:notiforyou/services/crud/notes_service.dart';
import 'package:notiforyou/utilities/dialogs/logout_dialog.dart';
import 'package:notiforyou/view/notes/notes_list_view.dart';
import 'package:notiforyou/view/widgets/pixel_widgets.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;

  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _notesService = NotesService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PixelAppBar(
        title: "◉ YOUR NOTES ◉",
        actions: [
          PixelIconButton(
            icon: Icons.add,
            onPressed: () {
              Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
            },
            tooltip: "Create New Note",
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final signOut = await showLogOutDialog(context);
                    if (signOut) {
                      await AuthService.firebase().logout();
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                    }
                }
              },
              icon: const Icon(
                Icons.more_vert,
                color: EightBitTheme.primaryText,
              ),
              color: EightBitTheme.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(EightBitTheme.pixelRadius),
                side: const BorderSide(
                  color: EightBitTheme.borderColor,
                  width: EightBitTheme.pixelBorderWidth,
                ),
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "► SIGN OUT ◄",
                        style: EightBitTheme.bodyStyle,
                      ),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              EightBitTheme.primaryBackground,
              EightBitTheme.secondaryBackground,
            ],
          ),
        ),
        child: FutureBuilder(
          future: _notesService.getOrCreateUser(email: userEmail),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return StreamBuilder(
                  stream: _notesService.allNotes,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          final allNotes = snapshot.data as List<DatabaseNote>;
                          if (allNotes.isEmpty) {
                            return _buildEmptyState();
                          }
                          return NotesListView(
                            notes: allNotes,
                            onTap: (note) {
                              Navigator.of(context).pushNamed(createOrUpdateNoteRoute, arguments: note);
                            },
                            onDeleteNote: (note) async {
                              await _notesService.deleteNote(id: note.id);
                            },
                          );
                        } else {
                          return _buildLoadingState();
                        }
                      default:
                        return _buildLoadingState();
                    }
                  },
                );
              default:
                return _buildLoadingState();
            }
          },
        ),
      ),
      floatingActionButton: Container(
        decoration: EightBitTheme.pixelButtonDecoration(),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
          },
          backgroundColor: EightBitTheme.primaryButton,
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: EightBitTheme.primaryBackground,
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: PixelContainer(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "◊ NO NOTES YET ◊",
                style: EightBitTheme.headingStyle.copyWith(
                  color: EightBitTheme.accentText,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Your adventure log is empty!\nCreate your first note to begin.",
                style: EightBitTheme.bodyStyle.copyWith(
                  color: EightBitTheme.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              PixelButton(
                text: "CREATE FIRST NOTE",
                onPressed: () {
                  Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
                },
                width: double.infinity,
                height: 48,
              ),
              const SizedBox(height: 16),
              Text(
                "▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼",
                style: EightBitTheme.bodyStyle.copyWith(
                  color: EightBitTheme.tertiaryBackground,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: PixelContainer(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "LOADING...",
              style: EightBitTheme.headingStyle.copyWith(
                color: EightBitTheme.accentText,
              ),
            ),
            const SizedBox(height: 16),
            const PixelProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              "Initializing game data...",
              style: EightBitTheme.bodyStyle.copyWith(
                color: EightBitTheme.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}