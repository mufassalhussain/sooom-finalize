class ExploreSellerModel {
  int? statusCode;
  List<Data>? data;

  ExploreSellerModel({this.statusCode, this.data});

  ExploreSellerModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? country;
  String? state;
  String? city;
  String? customerId;
  String? logo;
  String? description;
  String? content;
  String? status;
  Null? vendorVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Storelocations? storelocations;
  Customer? customer;
  List<Review>? review;

  Data(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.country,
      this.state,
      this.city,
      this.customerId,
      this.logo,
      this.description,
      this.content,
      this.status,
      this.vendorVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.storelocations,
      this.customer,
      this.review});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    customerId = json['customer_id'];
    logo = json['logo'];
    description = json['description'];
    content = json['content'];
    status = json['status'];
    vendorVerifiedAt = json['vendor_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    storelocations = json['storelocations'] != null
        ? new Storelocations.fromJson(json['storelocations'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['customer_id'] = this.customerId;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['content'] = this.content;
    data['status'] = this.status;
    data['vendor_verified_at'] = this.vendorVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.storelocations != null) {
      data['storelocations'] = this.storelocations!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Storelocations {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? country;
  String? state;
  String? city;
  String? isPrimary;
  String? isShippingLocation;
  String? createdAt;
  String? updatedAt;

  Storelocations(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.country,
      this.state,
      this.city,
      this.isPrimary,
      this.isShippingLocation,
      this.createdAt,
      this.updatedAt});

  Storelocations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    isPrimary = json['is_primary'];
    isShippingLocation = json['is_shipping_location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['is_primary'] = this.isPrimary;
    data['is_shipping_location'] = this.isShippingLocation;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? email;
  String? password;
  String? avatar;
  String? dob;
  String? phone;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? confirmedAt;
  Null? emailVerifyToken;
  String? isVendor;
  String? vendorVerifiedAt;
  String? status;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.avatar,
      this.dob,
      this.phone,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.confirmedAt,
      this.emailVerifyToken,
      this.isVendor,
      this.vendorVerifiedAt,
      this.status});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
    dob = json['dob'];
    phone = json['phone'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    confirmedAt = json['confirmed_at'];
    emailVerifyToken = json['email_verify_token'];
    isVendor = json['is_vendor'];
    vendorVerifiedAt = json['vendor_verified_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['dob'] = this.dob;
    data['phone'] = this.phone;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['confirmed_at'] = this.confirmedAt;
    data['email_verify_token'] = this.emailVerifyToken;
    data['is_vendor'] = this.isVendor;
    data['vendor_verified_at'] = this.vendorVerifiedAt;
    data['status'] = this.status;
    return data;
  }
}

class Review {
  int? id;
  String? customerId;
  String? sellerId;
  String? name;
  String? review;
  String? status;
  String? createdate;
  String? updatedAt;
  String? createdAt;
  CustomerDetails? customer;

  Review(
      {this.id,
      this.customerId,
      this.sellerId,
      this.name,
      this.review,
      this.status,
      this.createdate,
      this.updatedAt,
      this.createdAt,
      this.customer});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    sellerId = json['seller_id'];
    name = json['name'];
    review = json['review'];
    status = json['status'];
    createdate = json['createdate'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    customer = json['customer'] != null
        ? new CustomerDetails.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['seller_id'] = this.sellerId;
    data['name'] = this.name;
    data['review'] = this.review;
    data['status'] = this.status;
    data['createdate'] = this.createdate;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class CustomerDetails {
  int? id;
  String? name;

  CustomerDetails({this.id, this.name});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
