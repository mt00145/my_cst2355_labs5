import 'package:flutter/material.dart';
import 'database.dart';
import 'items.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Items> items = [];

  late TextEditingController _itemcontroller;
  late TextEditingController _quantityController;

  late var ItemsDao;
  @override
  void initState() {
    super.initState();
    _itemcontroller = TextEditingController();
    _quantityController = TextEditingController();
    // Initialize controller
    initDatabase();
  }

  @override
  void dispose() {
    _itemcontroller.dispose();
    _quantityController.dispose();// Dispose controller
    super.dispose();
  }
  void initDatabase() async {
    final database = await $FloorAppDatabase.databaseBuilder('items_database.db').build();
    ItemsDao = database.itemsDao;

    ItemsDao.findAllItems().then(
          (list) {
        setState(() {
          items = list;
        });
      },
    );
  }
  Widget ListPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _itemcontroller,
                  decoration: const InputDecoration(
                    hintText: 'Type the item here',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    hintText: 'Type the quantity here',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_itemcontroller.text.isNotEmpty && _quantityController.text.isNotEmpty) {
                    final newItem = Items(_itemcontroller.text, _quantityController.text);
                    await ItemsDao.insertItem(newItem);
                    setState(() {
                      items.add(newItem);
                      _itemcontroller.clear();
                      _quantityController.clear();
                    });
                  }
                },

                child: const Text("click here"),
              ),
            ],
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const Center(
            child: Text("There are no items in the list."),
          )
              : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Item'),
                      content: const Text('Do you want to delete this item?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // cancel
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await ItemsDao.deleteItem(items[index]); // delete from DB
                            items = await ItemsDao.findAllItems();  // reload items
                            setState(() {}); // refresh UI
                            Navigator.pop(context); // close dialog
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );
                },
                child: Center(
                  child: Text('${index + 1}: ${items[index].item} quantity: ${items[index].quantity}'),

                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListPage(), // Show the list and input form
    );
  }
}