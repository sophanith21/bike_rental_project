import 'package:bike_rental_project/data/dtos/bike/bike_slot_dto.dart';
import 'package:bike_rental_project/data/dtos/booking/booking_dto.dart';
import 'package:bike_rental_project/data/repositories/booking/booking_repository.dart';
import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/booking/booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class BookingRepositoryProd implements BookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _bookingsCollection =>
      _firestore.collection('bookings');

  @override
  Future<void> createNewBooking(Booking newBook) async {
    final slotRef = _firestore.collection('bike_slots').doc(newBook.bikeSlotId);
    final bookingRef = _firestore.collection('bookings').doc(newBook.id);

    // Pre-serialize to catch any "Enum" or "Data" issues before the transaction starts
    final bookingMap = BookingDto.toJson(newBook);

    try {
      await _firestore.runTransaction((transaction) async {
        // 1. MUST BE A DOCUMENT GET
        DocumentSnapshot slotSnapshot = await transaction.get(slotRef);

        if (!slotSnapshot.exists) {
          debugPrint("This bike slot no longer exists.");
          throw Exception("This bike slot no longer exists.");
        }

        final currentStatus = slotSnapshot.get(BikeSlotDto.bikeSlotStatusKey);
        if (currentStatus != BikeSlotStatus.occupied.name) {
          debugPrint("Too late! This slot was just taken.");

          throw Exception("Too late! This slot was just taken.");
        }

        // 2. Perform writes
        transaction.set(bookingRef, bookingMap);
        transaction.update(slotRef, {
          BikeSlotDto.bikeSlotStatusKey: BikeSlotStatus.booked.name,
        });
      });
    } catch (e) {
      debugPrint("Transaction failed: $e");
      rethrow;
    }
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
