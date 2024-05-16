// ignore_for_file: file_names

import 'package:assignment/Favourite.dart';
import 'package:assignment/boxes.dart';
import 'package:assignment/components/store.dart';
import 'package:assignment/views/Liked.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  static const String routeName = "profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Favorite fav = Favorite(index: {});

  @override
  void initState() {
    super.initState();
    if (boxFavourite.isNotEmpty) {
      fav = boxFavourite.getAt(0);
    } else {
      fav = Favorite(index: {});
      boxFavourite.put(0, fav);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stores'),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                // Navigate to the settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LikedStores()),
                );
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: Stores.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10),
              child: Container(
                width: 200.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 185, 189, 192),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Text(
                      Stores[index].name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        fav.index.containsValue(Stores[index].name)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        if (fav.index.containsKey(index)) {
                          fav.index.remove(index);
                        } else {
                          fav.index[index] = Stores[index].name;
                        }

                        await boxFavourite.putAt(0, fav);
                        setState(() {});
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
