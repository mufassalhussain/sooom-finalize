class CustomOrders {
  int? statusCode;
  String? msg;
  List<Data>? data;

  CustomOrders({this.statusCode, this.msg, this.data});

  CustomOrders.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? partNumber;
  String? quantity;
  String? price;
  String? chassisNumber;
  String? productDetails;
  String? image;
  String? productType;
  String? brandId;
  String? carModelId;
  String? year;
  Null? priceType;
  String? customerId;
  String? createdAt;
  String? status;
  String? productId;
  String? approveId;
  String? updatedAt;
  String? orderNumber;
  String? lastStatus;
  List<Bids>? bids;

  Data(
      {this.id,
      this.name,
      this.partNumber,
      this.quantity,
      this.price,
      this.chassisNumber,
      this.productDetails,
      this.image,
      this.productType,
      this.brandId,
      this.carModelId,
      this.year,
      this.priceType,
      this.customerId,
      this.createdAt,
      this.status,
      this.productId,
      this.approveId,
      this.updatedAt,
      this.orderNumber,
      this.lastStatus,
      this.bids});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    partNumber = json['part_number'];
    quantity = json['quantity'];
    price = json['price'];
    chassisNumber = json['chassis_number'];
    productDetails = json['product_details'];
    image = json['image'];
    productType = json['product_type'];
    brandId = json['brand_id'];
    carModelId = json['car_model_id'];
    year = json['year'];
    priceType = json['price_type'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    status = json['status'];
    productId = json['product_id'];
    approveId = json['approve_id'];
    updatedAt = json['updated_at'];
    orderNumber = json['order_number'];
    lastStatus = json['last_status'];
    if (json['bids'] != null) {
      bids = <Bids>[];
      json['bids'].forEach((v) {
        bids!.add(new Bids.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['part_number'] = this.partNumber;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['chassis_number'] = this.chassisNumber;
    data['product_details'] = this.productDetails;
    data['image'] = this.image;
    data['product_type'] = this.productType;
    data['brand_id'] = this.brandId;
    data['car_model_id'] = this.carModelId;
    data['year'] = this.year;
    data['price_type'] = this.priceType;
    data['customer_id'] = this.customerId;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['product_id'] = this.productId;
    data['approve_id'] = this.approveId;
    data['updated_at'] = this.updatedAt;
    data['order_number'] = this.orderNumber;
    data['last_status'] = this.lastStatus;
    if (this.bids != null) {
      data['bids'] = this.bids!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bids {
  int? id;
  String? bidId;
  String? productId;
  String? type;
  String? price;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Bids(
      {this.id,
      this.bidId,
      this.productId,
      this.type,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.product});

  Bids.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bidId = json['bid_id'];
    productId = json['product_id'];
    type = json['type'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bid_id'] = this.bidId;
    data['product_id'] = this.productId;
    data['type'] = this.type;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? productId;
  String? customorderId;
  String? customerId;
  String? storeId;
  String? amount;
  String? negotiate;
  String? bidStatus;
  String? weight;
  String? length;
  String? width;
  String? height;
  String? shippingPrice;
  String? createdAt;
  String? updatedAt;
  String? returnProduct;
  String? productCondition;
  ProductDetail? productDetail;

  Product(
      {this.id,
      this.productId,
      this.customorderId,
      this.customerId,
      this.storeId,
      this.amount,
      this.negotiate,
      this.bidStatus,
      this.weight,
      this.length,
      this.width,
      this.height,
      this.shippingPrice,
      this.createdAt,
      this.updatedAt,
      this.returnProduct,
      this.productCondition,
      this.productDetail});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customorderId = json['customorder_id'];
    customerId = json['customer_id'];
    storeId = json['store_id'];
    amount = json['amount'];
    negotiate = json['negotiate'];
    bidStatus = json['bid_status'];
    weight = json['weight'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    shippingPrice = json['shipping_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    returnProduct = json['return_product'];
    productCondition = json['product_condition'];
    productDetail = json['product_detail'] != null
        ? new ProductDetail.fromJson(json['product_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['customorder_id'] = this.customorderId;
    data['customer_id'] = this.customerId;
    data['store_id'] = this.storeId;
    data['amount'] = this.amount;
    data['negotiate'] = this.negotiate;
    data['bid_status'] = this.bidStatus;
    data['weight'] = this.weight;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['shipping_price'] = this.shippingPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['return_product'] = this.returnProduct;
    data['product_condition'] = this.productCondition;
    if (this.productDetail != null) {
      data['product_detail'] = this.productDetail!.toJson();
    }
    return data;
  }
}

class ProductDetail {
  int? id;
  String? name;
  String? description;
  String? content;
  String? status;
  List<String>? images;
  String? sku;
  String? order;
  String? quantity;
  String? allowCheckoutWhenOutOfStock;
  String? withStorehouseManagement;
  String? isFeatured;
  String? brandId;
  String? isVariation;
  String? saleType;
  String? price;
  String? salePrice;
  Null? startDate;
  Null? endDate;
  String? length;
  String? wide;
  String? height;
  String? weight;
  String? taxId;
  String? views;
  String? createdAt;
  String? updatedAt;
  String? stockStatus;
  String? storeId;
  String? createdById;
  String? createdByType;
  String? approvedBy;
  Null? image;
  String? customerId;
  String? carModelId;
  Null? year;
  Null? partNumber;
  Null? engine;
  Null? trim;
  String? shippingPrice;
  Null? productCondition;
  Null? productRating;
  String? returnable;
  Store? store;

  ProductDetail(
      {this.id,
      this.name,
      this.description,
      this.content,
      this.status,
      this.images,
      this.sku,
      this.order,
      this.quantity,
      this.allowCheckoutWhenOutOfStock,
      this.withStorehouseManagement,
      this.isFeatured,
      this.brandId,
      this.isVariation,
      this.saleType,
      this.price,
      this.salePrice,
      this.startDate,
      this.endDate,
      this.length,
      this.wide,
      this.height,
      this.weight,
      this.taxId,
      this.views,
      this.createdAt,
      this.updatedAt,
      this.stockStatus,
      this.storeId,
      this.createdById,
      this.createdByType,
      this.approvedBy,
      this.image,
      this.customerId,
      this.carModelId,
      this.year,
      this.partNumber,
      this.engine,
      this.trim,
      this.shippingPrice,
      this.productCondition,
      this.productRating,
      this.returnable,
      this.store});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    content = json['content'];
    status = json['status'];
    images = json['images'].cast<String>();
    sku = json['sku'];
    order = json['order'];
    quantity = json['quantity'];
    allowCheckoutWhenOutOfStock = json['allow_checkout_when_out_of_stock'];
    withStorehouseManagement = json['with_storehouse_management'];
    isFeatured = json['is_featured'];
    brandId = json['brand_id'];
    isVariation = json['is_variation'];
    saleType = json['sale_type'];
    price = json['price'];
    salePrice = json['sale_price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    length = json['length'];
    wide = json['wide'];
    height = json['height'];
    weight = json['weight'];
    taxId = json['tax_id'];
    views = json['views'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stockStatus = json['stock_status'];
    storeId = json['store_id'];
    createdById = json['created_by_id'];
    createdByType = json['created_by_type'];
    approvedBy = json['approved_by'];
    image = json['image'];
    customerId = json['customer_id'];
    carModelId = json['car_model_id'];
    year = json['year'];
    partNumber = json['part_number'];
    engine = json['engine'];
    trim = json['trim'];
    shippingPrice = json['shipping_price'];
    productCondition = json['product_condition'];
    productRating = json['product_rating'];
    returnable = json['returnable'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['content'] = this.content;
    data['status'] = this.status;
    data['images'] = this.images;
    data['sku'] = this.sku;
    data['order'] = this.order;
    data['quantity'] = this.quantity;
    data['allow_checkout_when_out_of_stock'] = this.allowCheckoutWhenOutOfStock;
    data['with_storehouse_management'] = this.withStorehouseManagement;
    data['is_featured'] = this.isFeatured;
    data['brand_id'] = this.brandId;
    data['is_variation'] = this.isVariation;
    data['sale_type'] = this.saleType;
    data['price'] = this.price;
    data['sale_price'] = this.salePrice;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['length'] = this.length;
    data['wide'] = this.wide;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['tax_id'] = this.taxId;
    data['views'] = this.views;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stock_status'] = this.stockStatus;
    data['store_id'] = this.storeId;
    data['created_by_id'] = this.createdById;
    data['created_by_type'] = this.createdByType;
    data['approved_by'] = this.approvedBy;
    data['image'] = this.image;
    data['customer_id'] = this.customerId;
    data['car_model_id'] = this.carModelId;
    data['year'] = this.year;
    data['part_number'] = this.partNumber;
    data['engine'] = this.engine;
    data['trim'] = this.trim;
    data['shipping_price'] = this.shippingPrice;
    data['product_condition'] = this.productCondition;
    data['product_rating'] = this.productRating;
    data['returnable'] = this.returnable;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    return data;
  }
}

class Store {
  int? id;
  String? name;
  String? logo;
  String? customerId;

  Store({this.id, this.name, this.logo, this.customerId});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['customer_id'] = this.customerId;
    return data;
  }
}
