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
        useMaterial3: true,
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
  late var ItemsDao;
  // final List<String> items = [];
  final List<String> quantities = [];
  final TextEditingController itemController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize controller
    initDatabase();
  }

  @override
  void dispose() {
    itemController.dispose();
    quantityController.dispose();// Dispose controller
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


  void addButton() async {
    final item = itemController.text.trim();
    final quantity = quantityController.text.trim();

    if (itemController.text.isNotEmpty && quantityController.text.isNotEmpty) {
      final newItem = Items(itemController.text, quantityController.text);
      await ItemsDao.insertItem(newItem);
      setState(() {
        items.add(newItem);
        itemController.clear();
        quantityController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F0FF),
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Input Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextField(
                    controller: itemController,
                    decoration: const InputDecoration(
                      hintText: "Type the item here",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                      hintText: "Type the quantity here",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: addButton,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFF8F0FF),
                    elevation: 1.5, // Shadow depth
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text("Click here"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Item List
            Expanded(
              child: items.isEmpty
                  ? const Text("There are no items in the list.")
                  : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: GestureDetector(
                      onLongPress: () => _confirmDelete(index),
                      child: Text(
                        '${index + 1}: ${items[index]}  quantity: ${quantities[index]}',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
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


  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await ItemsDao.deleteItem(items[index]); // delete from DB
              items = await ItemsDao.findAllItems();  // reload items
              setState(() {}); // refresh UI
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}