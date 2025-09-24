import  'package:uuid/uuid.dart';

class Plant {
  final String name;
  final String scientificname;
  final String imagepath;
  final String description;
  final String id;
  final int waterday;
  final String sunlight;
  final String soiltype;
  int followed = 0;

   Plant({
    String? id,
    required this.name,
    required this.scientificname,
    required this.imagepath,
    required this.description,
    required this.waterday,
    required this.sunlight,
    required this.soiltype,

  }) : id = id ?? Uuid().v4();


   Map<String, Object?> toMap() {
     return {
       'id': id,
       'name': name,
       'scientificname': scientificname,
       'description': description,
       'waterday': waterday,
       'sunlight': sunlight,
       'soiltype': soiltype,
       'imagepath': imagepath,
       'followed': followed,
     };
   }

   void changeFollow(){
     if(followed == 0){
       followed = 1;
     }else{
       followed = 0;
     }
   }
}