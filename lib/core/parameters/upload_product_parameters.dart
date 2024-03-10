import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class ProductParameters {
  final String? productId;
  final String? catId;
  final String? subCatId;
  final String? nameAr;
  final String? nameEn;
  final String? salePrice;
  final File? mainImage;
  final String? locationAr;
  final String? locationEn;
  final String? method;
  final String? descriptionAr;
  final String? descriptionEn;
  final String? coordinates;
  final String? mapLocation;
  final String? youtubeLink;
  final String? advantagesEn;
  final String? advantagesAr;
  final String? defectsEn;
  final String? defectsAr;
  // final String? method;
  final List<File>? images;

  ProductParameters({
    this.productId,
    required this.catId,
     this.method,
    required this.subCatId,
    required this.nameAr,
    required this.nameEn,
    required this.salePrice,
    required this.mainImage,
    required this.locationAr,
    // required this.method,
    required this.locationEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.coordinates,
    required this.mapLocation,
    required this.youtubeLink,
    required this.advantagesEn,
    required this.advantagesAr,
    required this.defectsEn,
    required this.defectsAr,
    required this.images,
  });

  Future<Map<String, dynamic>> toMap() async {
    final formData = FormData();
    if(images!=null) {
      images?.forEach((element) async{
      formData.files.add(MapEntry("images", await MultipartFile.fromFile(
        element.path,
        filename: path.basename(element.path),
      )));
    });
    }
    Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = catId;
    data['sub_category_id'] = subCatId;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['sale_price'] = salePrice;
    if(mainImage!=null) {
      data['main_image'] =mainImage!=null? await MultipartFile.fromFile(
      mainImage!.path,
      filename: path.basename(mainImage!.path),
    ):null;
    }
    data['location_ar'] = locationAr;
    data['location_en'] = locationEn;
    data['description_ar'] = descriptionAr;
    data['description_en'] = descriptionEn;
    data['coordinates'] = coordinates;
    data['map_location'] = mapLocation;
    data['youtube_link'] = youtubeLink;
    data['advantages_ar'] = advantagesAr;
    data['_method'] = method;
    data['advantages_en'] = advantagesEn;
    data['defects_ar'] = descriptionAr;
    data['defects_en'] = defectsEn;
    // data['_method'] = method;
    formData.files.map((e) {
      data.addAll({e.key:e.value});
    });
    return data;
  }
}
