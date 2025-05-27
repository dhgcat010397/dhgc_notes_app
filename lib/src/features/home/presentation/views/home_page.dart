import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:dhgc_notes_app/src/core/routes/app_routes.dart';
import 'package:dhgc_notes_app/src/core/helpers/string_helper.dart'
    show cleanedQuery;
import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';
import 'package:dhgc_notes_app/src/features/home/presentation/bloc/note_bloc.dart';
import 'package:dhgc_notes_app/src/features/home/presentation/views/add_or_update_note_popup.dart';
import 'package:dhgc_notes_app/src/features/home/presentation/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes App')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoteDialog();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NoteAppSearchBar(
              onSearch: (query) {
                _searchQuery = cleanedQuery(query);
                debugPrint('Search query: "$_searchQuery"');

                context.read<NoteBloc>().add(
                  NoteEvent.filterNotesByTitle(_searchQuery),
                );
              },
            ),
          ),

          // Notes list
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: BlocBuilder<NoteBloc, NoteState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  return state.when(
                    initial: () => const Center(child: Text('Initial State')),
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    loaded: (data, __, ___, ____, _____) {
                      final notesList = data;

                      return notesList.isEmpty
                          ? const Center(child: Text('No notes found'))
                          : ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: notesList.length,
                            itemBuilder: (context, index) {
                              final note = notesList[index];

                              return Card(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                elevation: 2,
                                child: ListTile(
                                  title: Text(note.title),
                                  subtitle: Text(note.content),
                                  onTap: () async {
                                    // Handle note tap, e.g., navigate to detail page
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   AppRoutes.noteDetail,
                                    //   arguments: note.id,
                                    // );
                                  },
                                  trailing: IconButton(
                                    icon: const Icon(Icons.more_vert),
                                    onPressed: () {
                                      _showActionMenu(note);
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                    },
                    error:
                        (errorCode, errorMessage) =>
                            Center(child: Text('Error: $errorMessage')),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    // Handle refresh logic, e.g., fetch notes from database
    context.read<NoteBloc>().add(NoteEvent.filterNotesByTitle(_searchQuery));
  }

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AddOrUpdateNotePopup(
          onSave: (title, content) {
            // Handle save logic, e.g., add note to database
            context.read<NoteBloc>().add(
              NoteEvent.addNote(title: title, content: content),
            );
          },
        );
      },
    );
  }

  void _showUpdateNoteDialog(NoteEntity note) {
    showDialog(
      context: context,
      builder: (_) {
        return AddOrUpdateNotePopup(
          isUpdateMode: true,
          title: note.title,
          content: note.content,
          onSave: (title, content) {
            // Handle save logic, e.g., update note to database
            final updatedNote = NoteEntity(
              id: note.id,
              title: title,
              content: content,
              createdAt: note.createdAt,
              modifiedAt: DateTime.now(),
            );

            context.read<NoteBloc>().add(NoteEvent.updateNote(updatedNote));
          },
        );
      },
    );
  }

  void _showActionMenu(NoteEntity note) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Update Note'),
              onTap: () {
                Navigator.pop(context);

                _showUpdateNoteDialog(note);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Note'),
              onTap: () {
                _showAlertDialog(
                  title: 'Delete Note',
                  content: 'Are you sure you want to delete this note?',
                  onConfirm: () {
                    Navigator.pop(context);

                    // Handle delete logic, e.g., delete note from database
                    context.read<NoteBloc>().add(
                      NoteEvent.deleteNote(note.id!),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showAlertDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
