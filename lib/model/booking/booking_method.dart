enum BookingType { pass, oneTime }

class BookingMethod {
  final String? passId;
  final String rentDate;
  final double price;
  final BookingType bookingType;

  const BookingMethod({
    required this.passId,
    required this.rentDate,
    required this.price,
    required this.bookingType,
  });
}
