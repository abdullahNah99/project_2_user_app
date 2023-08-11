import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_app/core/utils/cache_helper.dart';
import '../../../errors/failure.dart';
import '../../dio_helper.dart';

abstract class StorePropertyService {
  static Future<Either<Failure, void>> storeProperty({
    required PropertyModel propertyModel,
  }) async {
    try {
      await DioHelper.postWithImage(
        body: {
          'price': '${propertyModel.price}',
          'space': '${propertyModel.space}',
          'region_id': '${propertyModel.regionID}',
        },
        endPoint: 'properties/',
        imagesPath: propertyModel.images,
        token: await CacheHelper.getData(key: 'Token'),
      );
      return right(null);
    } catch (ex) {
      log('\nException: there is an error in storeProperty method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }

      return left(ServerFailure(ex.toString()));
    }
  }
}

class PropertyModel {
  final int price;
  final int space;
  final int regionID;
  final List<String> images;

  PropertyModel({
    required this.price,
    required this.space,
    required this.regionID,
    required this.images,
  });
}
