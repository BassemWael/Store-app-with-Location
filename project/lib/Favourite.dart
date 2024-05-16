import 'package:hive/hive.dart';

part 'Favourite.g.dart';

@HiveType(typeId: 2)
class Favorite {
  Favorite({required this.index});
  @HiveField(0)
  Map<int, String> index;
}
