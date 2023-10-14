import 'package:crud/popup_widget.dart';
import 'package:crud/todo%20model/todo_services.dart';
import 'package:flutter/material.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TextEditingController editTitleController = TextEditingController();
  TextEditingController editDescriptionController = TextEditingController();

  List<Todo> todoList = [];

  void showCustomModalBottomSheet(Todo todo) {
    editTitleController.text = todo.title;
    editDescriptionController.text = todo.description;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 480,
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: editTitleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Item Title',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: editDescriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Item Description',
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      String updatedTitle = editTitleController.text;
                      String updatedDescription =
                          editDescriptionController.text;
                      if (updatedTitle.isNotEmpty &&
                          updatedDescription.isNotEmpty) {
                        setState(() {
                          todo.title = updatedTitle;
                          todo.description = updatedDescription;
                        });

                        editTitleController.clear();
                        editDescriptionController.clear();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Edit Item',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item Title',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item Description',
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                ),
                onPressed: () {
                  String title = titleController.text;
                  String description = descriptionController.text;
                  if (title.isNotEmpty && description.isNotEmpty) {
                    setState(() {
                      todoList
                          .add(Todo(title: title, description: description));
                    });
                    titleController.clear();
                    descriptionController.clear();
                  } else if (title.isEmpty || description.isEmpty) {
                    PopupDialog.show(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add Item',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Alert'),
                            content: Text('Choose One What you want'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showCustomModalBottomSheet(
                                            todoList[index]);
                                      },
                                      child: Text('Edit'),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          todoList.removeAt(index);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading:
                            CircleAvatar(child: Text((index + 1).toString())),
                        title: Text(
                          todoList[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          todoList[index].description,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
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
