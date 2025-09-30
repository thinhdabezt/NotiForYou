import 'package:flutter/material.dart';
import 'package:notiforyou/constants/eight_bit_theme.dart';
import 'package:notiforyou/services/auth/auth_service.dart';
import 'package:notiforyou/services/crud/notes_service.dart';
import 'package:notiforyou/utilities/generics/get_arguments.dart';
import 'package:notiforyou/view/widgets/pixel_widgets.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  DatabaseNote? _note;
  late final NotesService _notesService;
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  String _characterCount = "0";
  Future<DatabaseNote>? _noteCreationFuture;
  bool _listenerSetup = false;

  @override
  void initState() {
    _notesService = NotesService();
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _textController.addListener(_updateCharacterCount);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_noteCreationFuture == null) {
      _noteCreationFuture = createOrGetExistingNote(context);
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateCharacterCount() {
    final newCount = _textController.text.length.toString();
    if (_characterCount != newCount) {
      setState(() {
        _characterCount = newCount;
      });
    }
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController.text;
    await _notesService.updateNote(note: note, text: text);
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<DatabaseNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<DatabaseNote>();

    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      _updateCharacterCount(); // Update character count after setting text
    }

    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }

    final currentUser = AuthService.firebase().currentUser!;
    final email = currentUser.email!;
    final owner = await _notesService.getUser(email: email);
    final newNote = await _notesService.createNote(owner: owner);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _notesService.deleteNote(id: note.id);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty) {
      await _notesService.updateNote(
        note: note,
        text: text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNewNote = _note == null || _note!.text.isEmpty;
    
    return Scaffold(
      appBar: PixelAppBar(
        title: isNewNote ? "NEW NOTE" : "EDIT NOTE",
        actions: [
          PixelIconButton(
            icon: Icons.save,
            onPressed: () {
              _saveNoteIfTextNotEmpty();
              Navigator.of(context).pop();
            },
            tooltip: "Save Note",
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
          future: _noteCreationFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!_listenerSetup) {
                  _setupTextControllerListener();
                  _listenerSetup = true;
                  // Ensure focus is requested after the widget is built
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_focusNode.canRequestFocus) {
                      _focusNode.requestFocus();
                    }
                  });
                }
                return _buildNoteEditor();
              default:
                return _buildLoadingState();
            }
          },
        ),
      ),
    );
  }

  Widget _buildNoteEditor() {
    return Column(
      children: [
        // Header with note info
        PixelContainer(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                "◉ NOTE EDITOR ◉",
                style: EightBitTheme.headingStyle.copyWith(
                  color: EightBitTheme.accentText,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: EightBitTheme.tertiaryBackground,
                  border: Border.all(
                    color: EightBitTheme.borderColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  "CHARS: $_characterCount",
                  style: EightBitTheme.bodyStyle.copyWith(
                    fontSize: 12,
                    color: EightBitTheme.primaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Text editor
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: PixelContainer(
              padding: const EdgeInsets.all(16),
              backgroundColor: EightBitTheme.inputBackground,
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                autofocus: true,
                textInputAction: TextInputAction.newline,
                style: EightBitTheme.bodyStyle,
                decoration: InputDecoration(
                  hintText: _getHintText(),
                  hintStyle: EightBitTheme.hintStyle.copyWith(
                    color: EightBitTheme.secondaryText.withValues(alpha: 0.6),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
        
        // Footer with instructions
        PixelContainer(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
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
                  "AUTO-SAVE ENABLED • EMPTY NOTES WILL BE DELETED",
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
              "INITIALIZING...",
              style: EightBitTheme.headingStyle.copyWith(
                color: EightBitTheme.accentText,
              ),
            ),
            const SizedBox(height: 16),
            const PixelProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              "Preparing note editor...",
              style: EightBitTheme.bodyStyle.copyWith(
                color: EightBitTheme.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getHintText() {
    return '''Welcome to your digital adventure log!

Start typing your thoughts, ideas, or mission notes here...

█ TIPS:
• Your progress auto-saves
• Use this space for anything
• Empty notes disappear when you exit

Ready to begin your quest?''';
  }
}