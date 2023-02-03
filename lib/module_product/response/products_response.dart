class ProductResponse {
  late String statusCode;
  late String msg;
  late List<Data> data;

  ProductResponse.fromJson(Map<String, dynamic> json) {

    statusCode = json['status_code'] == null? '':'';
    msg = json['msg'] == null ? '':'';
    // The second section of the condition when there are no services
    if (json['items'] != null && !(json['items'] is String)) {
      data =  <Data>[];
      json['items'].forEach((v) {
        data.add(new Data.fromJson(v));
      });

    } else {
      data = [];
    }
  }

}

class Data{
  Data.fromJson(Map<String, dynamic> data) {
  }
}









