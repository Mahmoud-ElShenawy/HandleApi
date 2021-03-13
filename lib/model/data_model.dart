class DataModel {
    String body;
    int id;
    String title;
    int userId;


    DataModel({this.body, this.id, this.title, this.userId});


    factory DataModel.fromJson(Map<String, dynamic> json) {
        return DataModel(
            body: json['body'],
            id: json['id'],
            title: json['title'],
            userId: json['userId'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['body'] = this.body;
        data['id'] = this.id;
        data['title'] = this.title;
        data['userId'] = this.userId;
        return data;
    }

}