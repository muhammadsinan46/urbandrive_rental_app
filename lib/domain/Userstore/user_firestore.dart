import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urbandrive/infrastructure/user_model.dart';

class UserFireStore {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Stream<List<UserModel>> getUsers() {
    return usersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return UserModel(
            id: doc.id,
            name: data['name'],
            email: data['email'],
            mobile: data['mobile'],
            profile: data['profile']);
      }).toList();
    });
  }

addUser(UserModel user)async{
  return usersCollection.add({
    "id": user.id,
    "name": user.name,
    "email": user.email,
    "mobile": user.mobile,
    "profile": user.profile
    
    
  });

}


updateUser(UserModel user)async{
  return usersCollection.doc(user.id).update( {
          "id": user.id,
    "name": user.name,
    "email": user.email,
    "mobile": user.mobile,
    "profile": user.profile
  });

}


deleteUser(UserModel user)async{
  return usersCollection.doc(user.id).delete();

}
}

       