import 'package:bike_rental_project/data/dto/bike/bike_slot_dto.dart';
import 'package:bike_rental_project/data/dto/bike/bike_station_dto.dart';
import 'package:bike_rental_project/data/dto/booking/booking_dto.dart';
import 'package:bike_rental_project/data/dto/booking/pass_subscription_dto.dart';
import 'package:bike_rental_project/data/dto/user/user_dto.dart';
import 'package:bike_rental_project/data/dto/user/user_pass_dto.dart';
import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:bike_rental_project/model/booking/booking.dart';
import 'package:bike_rental_project/model/booking/booking_method.dart';
import 'package:bike_rental_project/model/booking/pass_subscription.dart';
import 'package:bike_rental_project/model/user/user.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class SeedData {
  static final _db = FirebaseFirestore.instance;

  // Collection names
  static const String usersCollection = 'users';
  static const String userPassesCollection = 'user_passes';
  static const String bookingsCollection = 'bookings';
  static const String passSubscriptionsCollection = 'pass_subscriptions';
  static const String bikeSlotsCollection = 'bike_slots';
  static const String bikeStationsCollection = 'bike_stations';

  static Future<void> seedAll({bool reset = false}) async {
    if (reset) {
      print('🗑️  Clearing existing data...');
      await _clearCollection(usersCollection);
      await _clearCollection(userPassesCollection);
      await _clearCollection(bookingsCollection);
      await _clearCollection(passSubscriptionsCollection);
      await _clearCollection(bikeSlotsCollection);
      await _clearCollection(bikeStationsCollection);
      print('✅ All collections cleared!\n');
    }

    await seedUsers();
    await seedPassSubscriptions();
    await seedUserPasses();
    await seedBikeStations();
    await seedBikeSlots();
    await seedBookings();

    print('\n🎉 All mock data seeded successfully!');
  }

  // delete all docs in a collection
  static Future<void> _clearCollection(String collectionName) async {
    final snapshot = await _db.collection(collectionName).get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
    print('🗑️  Cleared: $collectionName');
  }

  // Users
  static Future<void> seedUsers() async {
    final users = [
      User(id: 'user_001', name: 'Allya'),
      User(id: 'user_002', name: 'Reaksa'),
      User(id: 'user_003', name: 'David'),
      User(id: 'user_004', name: 'Panith'),
    ];

    for (final user in users) {
      await _db
          .collection(usersCollection)
          .doc(user.id)
          .set(UserDto.toJson(user));
      print('👤 Added user: ${user.name}');
    }
  }

  // Pass Subscriptions
  static Future<void> seedPassSubscriptions() async {
    final passes = [
      PassSubscription(
        id: 'pass_sub_001',
        title: 'Daily Explorer',
        description: 'Best for quick "Grab & Go" access',
        price: 2.00,
        validDuration: const Duration(days: 1),
      ),
      PassSubscription(
        id: 'pass_sub_002',
        title: 'Monthly Habit',
        description: 'Best for city visit or business trip',
        price: 15.00,
        validDuration: const Duration(days: 30),
      ),
      PassSubscription(
        id: 'pass_sub_003',
        title: 'Annual Member',
        description: 'Daily commuters & year-round riders.',
        price: 99.00,
        validDuration: const Duration(days: 365),
      ),
    ];

    for (final pass in passes) {
      await _db
          .collection(passSubscriptionsCollection)
          .doc(pass.id)
          .set(PassSubscriptionDto.toJson(pass));
      print('🎫 Added pass subscription: ${pass.title}');
    }
  }

  //User Passes
  static Future<void> seedUserPasses() async {
    final now = DateTime.now();

    final userPasses = [
      UserPass(
        id: 'user_pass_001',
        userId: 'user_001',
        passSubscriptionId: 'pass_sub_002',
        startDate: now,
        expirationDate: now.add(const Duration(days: 7)),
        passStatus: PassStatus.active,
      ),
      UserPass(
        id: 'user_pass_002',
        userId: 'user_002',
        passSubscriptionId: 'pass_sub_003',
        startDate: now.subtract(const Duration(days: 35)),
        expirationDate: now.subtract(const Duration(days: 5)),
        passStatus: PassStatus.inactive,
      ),
      UserPass(
        id: 'user_pass_003',
        userId: 'user_003',
        passSubscriptionId: 'pass_sub_001',
        startDate: now,
        expirationDate: now.add(const Duration(days: 1)),
        passStatus: PassStatus.active,
      ),
    ];

    for (final userPass in userPasses) {
      await _db
          .collection(userPassesCollection)
          .doc(userPass.id)
          .set(UserPassDto.toJson(userPass));
      print('🪪 Added user pass: ${userPass.id} (${userPass.passStatus.name})');
    }
  }

  // Bike Stations
  static Future<void> seedBikeStations() async {
    final stations = [
      BikeStation(
        id: 'station_001',
        stationName: 'Central Market Station',
        stationLocation: const LatLng(11.5693, 104.9225),
      ),
      BikeStation(
        id: 'station_002',
        stationName: 'Royal Palace Station',
        stationLocation: const LatLng(11.5625, 104.9306),
      ),
      BikeStation(
        id: 'station_003',
        stationName: 'Riverside Station',
        stationLocation: const LatLng(11.5714, 104.9306),
      ),
      BikeStation(
        id: 'station_004',
        stationName: 'Toul Sleng Station',
        stationLocation: const LatLng(11.5496, 104.9172),
      ),
    ];

    for (final station in stations) {
      await _db
          .collection(bikeStationsCollection)
          .doc(station.id)
          .set(BikeStationDto.toJson(station));
      print('📍 Added station: ${station.stationName}');
    }
  }

  // Bike Slots
  static Future<void> seedBikeSlots() async {
    final slots = [
      // station_001 — 9 slots
      BikeSlot(
        id: 'slot_s1_001',
        slotNumber: 1,
        bikeStationId: 'station_001',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s1_002',
        slotNumber: 2,
        bikeStationId: 'station_001',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s1_003',
        slotNumber: 3,
        bikeStationId: 'station_001',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s1_004',
        slotNumber: 4,
        bikeStationId: 'station_001',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s1_005',
        slotNumber: 5,
        bikeStationId: 'station_001',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s1_006',
        slotNumber: 6,
        bikeStationId: 'station_001',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s1_007',
        slotNumber: 7,
        bikeStationId: 'station_001',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s1_008',
        slotNumber: 8,
        bikeStationId: 'station_001',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s1_009',
        slotNumber: 9,
        bikeStationId: 'station_001',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),

      // station_002 — 8 slots
      BikeSlot(
        id: 'slot_s2_001',
        slotNumber: 1,
        bikeStationId: 'station_002',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s2_002',
        slotNumber: 2,
        bikeStationId: 'station_002',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s2_003',
        slotNumber: 3,
        bikeStationId: 'station_002',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s2_004',
        slotNumber: 4,
        bikeStationId: 'station_002',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s2_005',
        slotNumber: 5,
        bikeStationId: 'station_002',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s2_006',
        slotNumber: 6,
        bikeStationId: 'station_002',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s2_007',
        slotNumber: 7,
        bikeStationId: 'station_002',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s2_008',
        slotNumber: 8,
        bikeStationId: 'station_002',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),

      // station_003 — 10 slots
      BikeSlot(
        id: 'slot_s3_001',
        slotNumber: 1,
        bikeStationId: 'station_003',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s3_002',
        slotNumber: 2,
        bikeStationId: 'station_003',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s3_003',
        slotNumber: 3,
        bikeStationId: 'station_003',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s3_004',
        slotNumber: 4,
        bikeStationId: 'station_003',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s3_005',
        slotNumber: 5,
        bikeStationId: 'station_003',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s3_006',
        slotNumber: 6,
        bikeStationId: 'station_003',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s3_007',
        slotNumber: 7,
        bikeStationId: 'station_003',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s3_008',
        slotNumber: 8,
        bikeStationId: 'station_003',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s3_009',
        slotNumber: 9,
        bikeStationId: 'station_003',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s3_010',
        slotNumber: 10,
        bikeStationId: 'station_003',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),

      // station_004 — 9 slots
      BikeSlot(
        id: 'slot_s4_001',
        slotNumber: 1,
        bikeStationId: 'station_004',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s4_002',
        slotNumber: 2,
        bikeStationId: 'station_004',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s4_003',
        slotNumber: 3,
        bikeStationId: 'station_004',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s4_004',
        slotNumber: 4,
        bikeStationId: 'station_004',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s4_005',
        slotNumber: 5,
        bikeStationId: 'station_004',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s4_006',
        slotNumber: 6,
        bikeStationId: 'station_004',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s4_007',
        slotNumber: 7,
        bikeStationId: 'station_004',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
      BikeSlot(
        id: 'slot_s4_008',
        slotNumber: 8,
        bikeStationId: 'station_004',
        bikeSlotStatus: BikeSlotStatus.empty,
      ),
      BikeSlot(
        id: 'slot_s4_009',
        slotNumber: 9,
        bikeStationId: 'station_004',
        bikeSlotStatus: BikeSlotStatus.occupied,
      ),
    ];
    for (final slot in slots) {
      await _db
          .collection(bikeSlotsCollection)
          .doc(slot.id)
          .set(BikeSlotDto.toJson(slot));
      print(
        '🚲 Added slot: ${slot.id} at station ${slot.bikeStationId} (${slot.bikeSlotStatus.name})',
      );
    }
  }

  // Bookings
  static Future<void> seedBookings() async {
    final now = DateTime.now();

    final bookings = [
      Booking(
        id: 'booking_001',
        userId: 'user_001',
        bikeSlotId: 'slot_001',
        createdAt: now.subtract(const Duration(hours: 2)),
        bookingStatus: BookingStatus.ongoing,
        bookingMethod: BookingMethod(
          passId: 'user_pass_001',
          rentDate: now.subtract(const Duration(hours: 2)).toIso8601String(),
          price: 0.00,
          bookingType: BookingType.pass,
        ),
      ),
      Booking(
        id: 'booking_002',
        userId: 'user_002',
        bikeSlotId: 'slot_003',
        createdAt: now.subtract(const Duration(days: 1)),
        bookingStatus: BookingStatus.complete,
        bookingMethod: BookingMethod(
          passId: '',
          rentDate: now.subtract(const Duration(days: 1)).toIso8601String(),
          price: 2.50,
          bookingType: BookingType.oneTime,
        ),
      ),
      Booking(
        id: 'booking_003',
        userId: 'user_003',
        bikeSlotId: 'slot_005',
        createdAt: now.subtract(const Duration(hours: 5)),
        bookingStatus: BookingStatus.ongoing,
        bookingMethod: BookingMethod(
          passId: 'user_pass_003',
          rentDate: now.subtract(const Duration(hours: 5)).toIso8601String(),
          price: 0.00,
          bookingType: BookingType.pass,
        ),
      ),
    ];

    for (final booking in bookings) {
      await _db
          .collection(bookingsCollection)
          .doc(booking.id)
          .set(BookingDto.toJson(booking));
      print('📋 Added booking: ${booking.id} (${booking.bookingStatus.name})');
    }
  }
}
