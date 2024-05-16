import 'package:assignment/Favourite.dart';
import 'package:assignment/boxes.dart';
import 'package:assignment/components/store.dart';
import 'package:assignment/views/Map.dart';
import 'package:flutter/material.dart';
import 'package:assignment/components/ChangeNotifier.dart';

final storeData = StoreData();
class LikedStores extends StatefulWidget {
  const LikedStores({super.key});
  static const String routeName = "liked";

  @override
  State<LikedStores> createState() => _LikedStoresState();
}

class _LikedStoresState extends State<LikedStores> {
  Favorite fav = boxFavourite.getAt(0);
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Stores'),
      ),
      body: ListView.builder(
        itemCount: Stores.length,
        itemBuilder: (context, index) {
          String? name = "";
          if (fav.index.containsKey(index)) {
            name = fav.index[index];
          }
          if (name != "") {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  storeData.setStoreData(Stores[index].xcoordinate, Stores[index].ycoordinate);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoreMap(),
                    ),
                  );
                },
                child: Container(
                  width: 380.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 185, 189, 192),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(name.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
