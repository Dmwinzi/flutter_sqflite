class Note{


  int? id;
  var title;
  var note;


  Note({
    this.id,
    required this.title,
    required this.note
});


  factory Note.fromJson(Map<String,dynamic> json){
    return Note(
      id : json["id"],
      title: json['title'],
      note:  json['note'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'note' : note,
    };
  }



}