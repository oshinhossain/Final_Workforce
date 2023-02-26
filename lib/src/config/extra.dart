// class Generic {
//   /// If T is a List, K is the subtype of the list.
//   static T fromJson<T, K>(dynamic json) {
//     if (json is List<T>) {
//       return _fromJsonList<K>(json) as T;
//     } else {
//       throw Exception('Unknown class');
//     }
//   }

//   static List<K>? _fromJsonList<K>(List<dynamic> jsonList) {
//     return jsonList.map<K>((dynamic json) => fromJson<K, void>(json)).toList();
//   }
// }
