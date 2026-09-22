
class PlacesEntity  {
  final String id;
  final String title;
  final String subtitle;
  final String location;
  final String description;
  final String note;
  final double rating;
  final String category;
  final String imageUrl;
  final String openingHours;
  final String entryFee;
   bool isSaved;

   PlacesEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.description,
    required this.note,
    required this.rating,
    required this.category,
    required this.imageUrl,
    required this.openingHours,
    required this.entryFee,
    this.isSaved = false, 
  });

 
}