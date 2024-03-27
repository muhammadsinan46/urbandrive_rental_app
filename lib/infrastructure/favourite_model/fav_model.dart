class FavouriteModel{


  final String userId;
  final String favId;
  final Map<String, dynamic> carmodel;
  final bool? isFavourite;


  FavouriteModel({required this.userId, required this.favId, required this.carmodel,  this.isFavourite});

}