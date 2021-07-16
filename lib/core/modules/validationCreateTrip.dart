import 'package:latlong2/latlong.dart';

import 'createTripFileHelp.dart';

class ValidationCreateTrip {
  static List<String> page1Validation(
      String title, DateTime fromDate, DateTime toDate, String tripType) {
    List<String> errorMessage = [];
    if (title.isEmpty) {
      errorMessage.add("Bạn quên điền tiêu đề kìa");
    } else if (title.length < 10 && title.length >= 1) {
      errorMessage.add("Tiêu đề phải có ít nhất 10 ký tự");
    }

    if (tripType.isEmpty) {
      errorMessage.add("Hãy chọn loại hình chuyến đi của bạn");
    }
    return errorMessage;
  }

  static List<String> page2Validation(String addProvince, String addTown,
      String addVillage, double lat, double long) {
    List<String> errorMessage = [];
    if (addProvince.isEmpty) {
      errorMessage.add("Phải điền Tỉnh/Thành phố bạn nhé");
    }
    if (lat == 0 || long == 0) {
      errorMessage.add("Bạn quên chưa chọn vị trí");
    }
    return errorMessage;
  }

  static List<String> page3Validation(List<SlotInfo> listSlot) {
    List<String> errorMessage = [];
    if (listSlot.isEmpty) {
      errorMessage.add("Bạn chưa thêm chỗ");
    }
    for (int i = 0; i < listSlot.length; i++) {
      if (listSlot[i].child == 0 && listSlot[i].adult == 0) {
        errorMessage.add("Xem lại số người kìa bạn");
      }
    }
    return errorMessage;
  }

  static Future<List<String>> page4Validation() async {
    List<String> errorMessage = [];
    await TripRegisterController.fileExisted().then((value) {
      if (!value) {
        errorMessage.add("Chọn vài ảnh đi nào");
      }
    }).onError((error, stackTrace) {
      errorMessage.add(error.toString());
    });
    return errorMessage;
  }
}
