class BannerResponse {
  List<Banners> banners;

  BannerResponse({this.banners});

  BannerResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      banners = new List<Banners>();
      json['data'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['data'] = this.banners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  int id;
  String image;
  String description;
  String status;
  String createdAt;
  String updatedAt;

  Banners(
      {this.id,
      this.image,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
