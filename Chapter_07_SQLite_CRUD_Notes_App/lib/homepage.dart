import 'package:flutter/material.dart';
import 'package:sqlite_app/db_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _notes = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Notes',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _titleController.clear();
          _descriptionController.clear();
          _showModal(null);
        },
      ),
      body: _notes.isEmpty
          ? const Center(
              child: Text(
                'No notes yet',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];

                return Card(
                  color: Colors.orange[200],
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Text(note['title'] as String? ?? ''),
                    subtitle: Text(note['description'] as String? ?? ''),
                    trailing: SizedBox(
                      width: 96,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _titleController.text =
                                  note['title'] as String? ?? '';
                              _descriptionController.text =
                                  note['description'] as String? ?? '';
                              _showModal(note['id'] as int);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await DatabaseService.deleteItem(
                                note['id'] as int,
                              );
                              _refreshNotes();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget modalComponent(int? id) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_titleController.text.trim().isEmpty &&
                  _descriptionController.text.trim().isEmpty) {
                return;
              }

              if (id == null) {
                await _addItem();
              } else {
                await _updateItem(id);
              }

              _titleController.clear();
              _descriptionController.clear();

              if (mounted) {
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            child: Text(
              id == null ? 'Create New' : 'Update',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showModal(int? id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return modalComponent(id);
      },
    );
  }

  void _refreshNotes() async {
    final data = await DatabaseService.getItems();

    if (!mounted) {
      return;
    }

    setState(() {
      _notes = data;
    });
  }

  Future<void> _addItem() async {
    await DatabaseService.createItem(
      _titleController.text,
      _descriptionController.text,
    );
    _refreshNotes();
  }

  Future<void> _updateItem(int id) async {
    await DatabaseService.updateItem(
      id,
      _titleController.text,
      _descriptionController.text,
    );
    _refreshNotes();
  }
}
