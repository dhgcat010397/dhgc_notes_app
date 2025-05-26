import 'package:dhgc_notes_app/src/core/routes/app_routes.dart';
import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';
import 'package:dhgc_notes_app/src/features/home/presentation/bloc/note_bloc.dart';
import 'package:dhgc_notes_app/src/features/home/presentation/views/add_or_update_note_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _searchQuery;

  @override
  void initState() {
    super.initState();

    _searchQuery = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes App')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoteDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search Notes',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // Handle search logic
                  },
                ),
              ),

              // Notes list
              BlocBuilder<NoteBloc, NoteState>(
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
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: notesList.length,
                            itemBuilder: (context, index) {
                              final note = notesList[index];

                              return ListTile(
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
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _showUpdateNoteDialog(context, note);
                                  },
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    // Handle refresh logic, e.g., fetch notes from database
    context.read<NoteBloc>().add(NoteEvent.filterNotesByTitle(_searchQuery));
  }

  void _showAddNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddOrUpdateNotePopup(
          onSave: (title, content) {
            // Handle save logic, e.g., add note to database
            context.read<NoteBloc>().add(
              NoteEvent.addNote(title: title, content: content),
            );

            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showUpdateNoteDialog(BuildContext context, NoteEntity note) {
    showDialog(
      context: context,
      builder: (context) {
        return AddOrUpdateNotePopup(
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

            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
