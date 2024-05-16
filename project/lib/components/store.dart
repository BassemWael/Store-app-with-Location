
class Store {
  int id;
  String name;
  double xcoordinate;
  double ycoordinate;

  Store({
    required this.id,
    required this.name,
    required this.xcoordinate,
    required this.ycoordinate,
  });
}

List<Store> Stores = [
  Store(id: 0,name: "Store1", xcoordinate: 54.3333, ycoordinate: 54.3333),
  Store(id: 1,name: "Store2", xcoordinate: 44.3333, ycoordinate: 44.3333),
  Store(id: 2,name: "Store3", xcoordinate: 34.3333, ycoordinate: 34.3333),
  Store(id: 3,name: "Store4", xcoordinate: 24.3333, ycoordinate: 24.3333),
  Store(id: 4,name: "Store5", xcoordinate: 14.3333, ycoordinate: 14.3333),
  Store(id: 5,name: "Store6", xcoordinate: 5.3333, ycoordinate: 54.3333),
  Store(id: 6,name: "Store7", xcoordinate: 4.3333, ycoordinate: 44.3333),
  Store(id: 7,name: "Store8", xcoordinate: 3.3333, ycoordinate: 34.3333),
  Store(id: 8,name: "Store9", xcoordinate: 2.3333, ycoordinate: 24.3333),
  Store(id: 9,name: "Store10", xcoordinate: 1.3333, ycoordinate: 14.3333),
];
