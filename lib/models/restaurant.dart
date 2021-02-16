import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final DocumentReference owner;
  int queued;

  Restaurant(
      {@required this.id,
      @required this.name,
      @required this.owner,
      this.queued})
      : assert(id != null, owner != null);
  @override
  List<Object> get props => [id, name, owner];

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'owner': owner,
    };
  }

  Map<String, Object> toDocument() {
    return {
      'name': name,
      'owner': owner,
    };
  }

  static Restaurant fromJson(Map<String, Object> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      owner: json['owner'] as DocumentReference,
    );
  }

  static Restaurant fromSnapShot(DocumentSnapshot snap) {
    return Restaurant(
      id: snap.id,
      name: snap['name'] as String,
      owner: snap['owner'] as DocumentReference,
    );
  }

  // // Other Method
  // void changeMax(String id, int C){

  // }
}
