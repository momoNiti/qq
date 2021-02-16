import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final DocumentReference owner;
  final int queued;

  const Restaurant(
      {@required this.id,
      @required this.name,
      @required this.owner,
      @required this.queued})
      : assert(id != null, owner != null);

  static const empty = Restaurant(id: '', name: null, owner: null, queued: 0);

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
      'queued': queued,
    };
  }

  static Restaurant fromJson(Map<String, Object> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      owner: json['owner'] as DocumentReference,
      queued: json['queued'] as int,
    );
  }

  static Restaurant fromSnapShot(DocumentSnapshot snap) {
    return Restaurant(
      id: snap.id,
      name: snap['name'] as String,
      owner: snap['owner'] as DocumentReference,
      queued: snap['queued'] as int,
    );
  }
}
