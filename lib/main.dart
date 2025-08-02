import 'package:flutter/material.dart';
import 'database.dart';
import 'items.dart';
import 'items_dao.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Items App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ItemsPage(),
    );
  }
}

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late AppDatabase database;
  late ItemsDao itemsDao;
  List<Items> items = [];
  Items? selectedItem;
  bool isDatabaseReady = false;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    database = await $FloorAppDatabase.databaseBuilder('database.db').build();
    itemsDao = database.itemsDao;
    setState(() {
      isDatabaseReady = true;
    });
    loadItems();
  }

  Future<void> loadItems() async {
    if (isDatabaseReady) {
      final allItems = await itemsDao.findAllItems();
      setState(() {
        items = allItems;
      });
    }
  }

  Future<void> addItem(String itemName, String quantity) async {
    if (isDatabaseReady) {
      final newItem = Items(itemName, quantity);
      await itemsDao.insertItem(newItem);
      loadItems();
    }
  }

  Future<void> deleteSelectedItem() async {
    if (selectedItem != null && selectedItem!.id != null) {
      await itemsDao.deleteItemById(selectedItem!.id!);
      setState(() {
        selectedItem = null;
      });
      loadItems();
    }
  }

  void selectItem(Items item) {
    setState(() {
      selectedItem = item;
    });
  }

  void clearSelection() {
    setState(() {
      selectedItem = null;
    });
  }

  Widget reactiveLayout() {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    if ((width > height) && (width > 720)) {
      // Tablet/Desktop layout - Master-Detail side by side
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: ListPage(),
          ),
          Expanded(
            flex: 1,
            child: DetailsPage(),
          ),
        ],
      );
    } else {
      // Phone layout - Full screen switching
      if (selectedItem == null) {
        return ListPage();
      } else {
        return DetailsPage();
      }
    }
  }

  Widget ListPage() {
    return Column(
      children: [
        // Add item form
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AddItemForm(onAddItem: addItem),
        ),
        // Items list
        Expanded(
          child: items.isEmpty
              ? Center(child: Text('No items found. Add some items!'))
              : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  title: Text(item.item),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Text('ID: ${item.id}'),
                  onTap: () => selectItem(item), // Changed from long-press to tap
                  selected: selectedItem?.id == item.id,
                  selectedTileColor: Colors.blue.withOpacity(0.1),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget DetailsPage() {
    if (selectedItem == null) {
      return Center(
        child: Text(
          'Select an item to view details',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Item Name: ${selectedItem!.item}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Quantity: ${selectedItem!.quantity}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Database ID: ${selectedItem!.id}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: deleteSelectedItem,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
                child: Text('Delete'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: clearSelection,
                child: Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items Manager'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isDatabaseReady ? reactiveLayout() : Center(child: CircularProgressIndicator()),
    );
  }
}

class AddItemForm extends StatefulWidget {
  final Function(String, String) onAddItem;

  AddItemForm({required this.onAddItem});

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _itemController = TextEditingController();
  final _quantityController = TextEditingController();

  void _addItem() {
    if (_itemController.text.isNotEmpty && _quantityController.text.isNotEmpty) {
      widget.onAddItem(_itemController.text, _quantityController.text);
      _itemController.clear();
      _quantityController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: InputDecoration(
                      labelText: 'Item Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _itemController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}