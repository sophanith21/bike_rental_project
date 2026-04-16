import 'package:bike_rental_project/data/dtos/booking/booking_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bike_rental_project/data/repositories/booking/booking_repository.dart';
import 'package:bike_rental_project/model/booking/booking.dart';

class BookingRepositoryProd implements BookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _bookingsCollection =>
      _firestore.collection('bookings');

  @override
  Future<void> createNewBooking(Booking newBook) async {
    // Using the ID from the Booking object as the Document ID
    await _bookingsCollection.doc(newBook.id).set(BookingDto.toJson(newBook));
  }

  @override
  Stream<Booking?> getActiveBooking(String userId) {
    return _bookingsCollection
        .where('userId', isEqualTo: userId)
        .where('bookingStatus', isEqualTo: BookingStatus.ongoing.name)
        .limit(1)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) return null;

          final doc = snapshot.docs.first;
          final data = doc.data() as Map<String, dynamic>;

          // Passing doc.id as the first positional argument
          return BookingDto.fromJson(doc.id, data);
        });
  }

  @override
  Future<void> updateBookingStatus(
    String bookingId,
    BookingStatus newStatus,
  ) async {
    await _bookingsCollection.doc(bookingId).update({
      'bookingStatus': newStatus.name,
    });
  }
}
