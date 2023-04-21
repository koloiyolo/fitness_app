class Checkpoint
{
  double longitude;
  double latitude;
  double distance;
  String time;

  Checkpoint({
    required this.longitude,
    required this.latitude,
    required this.distance,
    required this.time
  });

  List toList(){
    return [longitude, latitude, distance, time];
  }
  static Checkpoint fromList(List list){
    return Checkpoint(longitude: list[0], latitude: list[1], distance: list[2], time: list[3]);
  }
}
List checkpointsToList(List<Checkpoint> checkpoints){
  List dummy = [];
  for(Checkpoint checkpoint in checkpoints){
    dummy.add(checkpoint.toList());
  }
  return dummy;
}
List<Checkpoint> checkpointsFromList(List list){
  List<Checkpoint> dummy = [];
  for(List checkpoint in list){
    dummy.add(Checkpoint.fromList(checkpoint));
  }
  return dummy;
}