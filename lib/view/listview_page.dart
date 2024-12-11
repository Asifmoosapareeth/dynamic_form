import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  late Future<List<String>> _titles;
  late List<String> _productTitles;

  @override
  void initState() {
    super.initState();
    _titles = fetchProductTitles();
  }

  Future<List<String>> fetchProductTitles() async {
    const String apiUrl = "https://fakestoreapi.com/products";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _productTitles = data.map((item) => item['title'] as String).toList();
      return _productTitles;
    } else {
      throw Exception('Failed to load product titles');
    }
  }

  void _deleteItem(int index) {
    setState(() {
      _productTitles.removeAt(index);
      _titles = Future.value(_productTitles);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item deleted')),
    );
  }

  void _showBottomSheet(String title) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Item Details: $title', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),

            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Titles'),
      ),
      body: FutureBuilder<List<String>>(
        future: _titles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No product titles available'));
          }

          List<String> titles = snapshot.data!;

          return ListView.builder(
            itemCount: titles.length,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        _deleteItem(index);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Item Saved'),
                            backgroundColor: Colors.green,

                          ),
                        );
                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.save,
                      label: 'Save',
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Tapped on: ${titles[index]}'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  onLongPress: () {
                    _showBottomSheet(titles[index]);
                  },
                  child: ListTile(
                    title: Text(titles[index]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
