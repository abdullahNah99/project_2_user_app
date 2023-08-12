import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_app/core/api/services/property/store_property_service.dart';
import 'package:image_picker/image_picker.dart';

class TestUploadImages extends StatelessWidget {
  const TestUploadImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            final ImagePicker picker = ImagePicker();

            //picking multiple images
            final List<XFile> images =
                await picker.pickMultiImage(imageQuality: 70);

            List<String> pImsg = [];
            for (var i in images) {
              log('Image Path: ${i.path}');
              pImsg.add(i.path);

              // setState(() => _isUploading = true);
              // await APIs.sendChatImage(widget.user, File(i.path));
              // setState(() => _isUploading = false);
            }
            PropertyModel p = PropertyModel(
              price: 123,
              space: 55,
              regionID: 1,
              images: pImsg,
            );

            StorePropertyService.storeProperty(propertyModel: p);
          },
          child: const Text('Upload'),
        ),
      ),
    );
  }
}




// final multipartImageList = images
//                 .map((image) async => MultipartFile.fromFileSync(image.path,
//                     filename: image.path.split('/').last))
//                 .toList();

//             var formData = FormData.fromMap({
//               'price': 1000000,
//               'space': 99,
//               'region_id': 1,
//               'images': multipartImageList
//             });


// try {
//               await Dio().post('http://192.168.43.37:8000/api/properties/',
//                   data: formData,
//                   options: Options(
//                       receiveDataWhenStatusError: true,
//                       method: 'POST',
//                       headers: {
//                         'auth-token': await CacheHelper.getData(key: 'Token')
//                       }));
//             } catch (e) {
//               log(e.toString());
//             }