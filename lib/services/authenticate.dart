class FireStoreUtils {
  /*
  static Firestore firestore = Firestore.instance;
  static DocumentReference currentUserDocRef =
      firestore.collection(Constants.USERS).document(MyAppState.currentUser.userID);
  StorageReference storage = FirebaseStorage.instance.ref();

  Future<User> getCurrentUser(String uid) async {
    DocumentSnapshot userDocument =
        await firestore.collection(Constants.USERS).document(uid).get();
    if (userDocument != null && userDocument.exists) {
      return User.fromJson(userDocument.data);
    } else {
      return null;
    }


  }

  Future<User> updateCurrentUser(User user, BuildContext context) async {
    return await firestore
        .collection(Constants.USERS)
        .document(user.userID)
        .setData(user.toJson())
        .then((document) {
      return user;
    }, onError: (e) {
      print(e);
      //showAlertDialog(context, 'Error', 'Failed to Update, Please try again.');
      return null;
    });
  }

  Future<String> uploadUserImageToFireStorage(File image, String userID) async {
    StorageReference upload = storage.child("images/$userID.png");
    StorageUploadTask uploadTask = upload.putFile(image);
    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return downloadUrl.toString();
  }*/
}
