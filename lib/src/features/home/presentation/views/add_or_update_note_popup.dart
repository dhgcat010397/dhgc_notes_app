import 'package:dhgc_notes_app/src/core/utils/formatters/auto_capitalize_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddOrUpdateNotePopup extends StatefulWidget {
  const AddOrUpdateNotePopup({
    super.key,
    this.onSave,
    this.isUpdateMode = false,
    this.title = "",
    this.content = "",
  });

  final Function(String title, String content)? onSave;
  final bool isUpdateMode;
  final String? title, content;

  @override
  State<AddOrUpdateNotePopup> createState() => _AddOrUpdateNotePopupState();
}

class _AddOrUpdateNotePopupState extends State<AddOrUpdateNotePopup> {
  late TextEditingController _titleController, _contentController;
  late FocusNode _titleFocusNode, _contentFocusNode;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _titleFocusNode = FocusNode();
    _contentFocusNode = FocusNode();

    if (widget.isUpdateMode) {
      _titleController.text = widget.title ?? "";
      _contentController.text = widget.content ?? "";
    }

    _titleFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: AlertDialog(
          title:
              widget.isUpdateMode
                  ? const Text('Update Note')
                  : const Text('Add Note'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text fields for title
                TextField(
                  controller: _titleController,
                  focusNode: _titleFocusNode,
                  textCapitalization: TextCapitalization.sentences,
                  inputFormatters: [
                    AutoCapitalizeFormatter(),
                    FilteringTextInputFormatter.deny(
                      RegExp(r'\s\.'),
                    ), // Prevents trailing spaces and dots
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                // Text fields for content
                TextField(
                  controller: _contentController,
                  focusNode: _contentFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  minLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final content = _contentController.text;

                widget.onSave?.call(title, content);

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
