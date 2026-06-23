import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const NotesHome(),
    );
  }
}

class NotesHome extends StatefulWidget {
  const NotesHome({super.key});

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final CollectionReference<Map<String, dynamic>> notesCollection =
      FirebaseFirestore.instance.collection('notes');

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> addNote() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      showMessage('Please enter a title and content.');
      return;
    }

    try {
      await notesCollection.add({
        'title': title,
        'content': content,
        'timestamp': FieldValue.serverTimestamp(),
      });

      titleController.clear();
      contentController.clear();
      showMessage('Note added.');
    } catch (e) {
      showMessage('Error adding note: $e');
    }
  }

  Future<void> updateNote({
    required String noteId,
    required String title,
    required String content,
  }) async {
    if (title.isEmpty || content.isEmpty) {
      showMessage('Please enter a title and content.');
      return;
    }

    try {
      await notesCollection.doc(noteId).update({
        'title': title,
        'content': content,
      });

      if (!mounted) return;
      Navigator.pop(context);
      showMessage('Note updated.');
    } catch (e) {
      showMessage('Error updating note: $e');
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await notesCollection.doc(noteId).delete();
      showMessage('Note deleted.');
    } catch (e) {
      showMessage('Error deleting note: $e');
    }
  }

  void showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void showEditDialog(QueryDocumentSnapshot<Map<String, dynamic>> note) {
    final data = note.data();
    final editTitleController = TextEditingController(
      text: data['title'] as String? ?? '',
    );
    final editContentController = TextEditingController(
      text: data['content'] as String? ?? '',
    );

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editTitleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: editContentController,
                decoration: const InputDecoration(labelText: 'Content'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                updateNote(
                  noteId: note.id,
                  title: editTitleController.text.trim(),
                  content: editContentController.text.trim(),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).whenComplete(() {
      editTitleController.dispose();
      editContentController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Notes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Note Title',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Note Content',
              ),
              minLines: 2,
              maxLines: 4,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: addNote,
                icon: const Icon(Icons.add),
                label: const Text('Add Note'),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'All Notes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: notesCollection
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading notes.'));
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final notes = snapshot.data!.docs;

                  if (notes.isEmpty) {
                    return const Center(child: Text('No notes found yet.'));
                  }

                  return ListView.separated(
                    itemCount: notes.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      final data = note.data();
                      final title = data['title'] as String? ?? '';
                      final content = data['content'] as String? ?? '';

                      return ListTile(
                        title: Text(title),
                        subtitle: Text(content),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: 'Edit',
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => showEditDialog(note),
                            ),
                            IconButton(
                              tooltip: 'Delete',
                              icon:
                                  const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteNote(note.id),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
