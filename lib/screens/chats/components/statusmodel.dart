import 'package:get/get.dart';
import 'model.dart';

class DateController extends GetxController {
  final booking = Booking(date: "5E80FDA6-3FB3-4DE2-936B-6AA6334CF1A6").obs;
  updateBooking(String date) {
    booking.update((val) {
      val!.date = date;
    });
  }
}
