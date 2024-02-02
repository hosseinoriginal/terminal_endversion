import 'dart:io';

//-Class Bus
class Bus {
  String name;
  String type;
  List<String?> chair;

  Bus(this.name, this.type)
      : chair = List.generate((type == 'Vip') ? 30 : 44,
            (index) => index < 9 ? '0${index + 1}' : '${index + 1}');
}

//-Class Trip
class Trip {
  String origin;
  String destination;
  int price;
  Bus bus;

  Trip(this.origin, this.destination, this.price, this.bus);
}

//-Class Terminal
class Terminal {
  List<Bus> buses = [];
  List<Trip> trips = [];

  double income = 0;
  int cancelReservation = 0;
  int cancelBuy = 0;
  int emptyChair = 0;

//-Void CreateBus
  void createBus() {
    stdout.write('Bus name: ');
    String? nameBus = stdin.readLineSync();
    if (nameBus == '0') {
      return;
    }
    stdout.write('Bus type (1.Vip, 2.Normal): ');
    String? typeBus = stdin.readLineSync();
    if (typeBus == '1') {
      if (typeBus == '0') {
        return;
      }
      buses.add(Bus(nameBus!, 'Vip'));
      print('Bus create. ✔');
    } else if (typeBus == '2') {
      if (typeBus == '0') {
        return;
      }
      buses.add(Bus(nameBus!, 'Normal'));
      print('Bus create. ✔');
    } else {
      print('Invalid input.!');
      return;
    }
  }

//-Void CreateTrip
  void createTrip() {
    try {
      if (buses.isEmpty) {
        print('List bus is empty.!');
        return;
      }
      stdout.write('Choose bus type (1.Vip, 2.Normal): ');
      String? busType = stdin.readLineSync();
      if (busType == '0') {
        return;
      }
      if (busType == null || busType.isEmpty) {
        print('Invalid input.!');
        return;
      }
      List<Bus> filterBus;
      if (busType == '1') {
        filterBus = buses.where((bus) => bus.type == 'Vip').toList();
      } else if (busType == '2') {
        filterBus = buses.where((bus) => bus.type == 'Normal').toList();
      } else {
        print('Invalid input.!');
        return;
      }
      if (filterBus.isEmpty) {
        print('No buses available for the selected type.!');
        return;
      }
      print('Select a bus: ');
      for (int i = 0; i < filterBus.length; i++) {
        print(
            '${i + 1}. Name: ${filterBus[i].name} - Type: ${filterBus[i].type}');
      }
      String? indexBus = stdin.readLineSync();
      if (indexBus == '0') {
        return;
      }
      if (indexBus == null || indexBus.isEmpty) {
        print('Invalid input.!');
        return;
      }
      int index = int.parse(indexBus) - 1;
      if (index < 0 || index == null || index >= filterBus.length) {
        print('Invalid input.!');
        return;
      }
      stdout.write('Enter origin: ');
      String? origin = stdin.readLineSync();
      if (origin == '0') {
        return;
      }
      stdout.write('Enter destination: ');
      String? destination = stdin.readLineSync();
      if (destination == '0') {
        return;
      }
      stdout.write('Enter price: ');
      String? priceInput = stdin.readLineSync();
      if (priceInput == '0') {
        return;
      }
      int? price = int.tryParse(priceInput!);
      if (price == null) {
        print('Invalid input.!');
        return;
      }
      trips.add(Trip(origin!, destination!, price, buses[index]));
      print('Trip created. ✔');
    } catch (e) {
      print('Input invalid!');
    }
  }

//-Void DisplayTrips
  void displayTrips() {
    if (trips.isEmpty) {
      print('List trip is Empty.!');
      return;
    }
    print('List trips: ');
    for (int i = 0; i < trips.length; i++) {
      print(
          '${i + 1} => Name: ${buses[i].name} - Type: ${buses[i].type} - ${trips[i].origin} to ${trips[i].destination} - ${trips[i].price} T');
    }
  }

//Void DisplaySeat
  void showSeats(Bus bus) {
    try {
      print('Available seats for ${bus.name} (${bus.type} bus): ');
      for (int i = 0; i < bus.chair.length; i += 2) {
        print('${bus.chair[i]} ${bus.chair[i + 1]}     ');
      }
    } catch (e) {
      print('Input invalid!');
    }
  }

//-Void BookTicket
  void bookTicket() {
    try {
      if (trips.isEmpty) {
        print('No trips available for booking.!');
        return;
      }
      print('Select a trip to book a ticket: ');
      displayTrips();
      String? indexTrip = stdin.readLineSync();
      if (indexTrip == '0') {
        return;
      }
      if (indexTrip == null || indexTrip.isEmpty) {
        print('Invalid input.!');
        return;
      }
      int index = int.parse(indexTrip) - 1;
      if (index < 0 || index == null || index >= trips.length) {
        print('Invalid input.!');
        return;
      }
      Bus bus = buses[index];
      showSeats(bus);
      stdout.write('Enter the seat number you want to book: ');
      String? seatNumber = stdin.readLineSync();
      if (seatNumber == '0') {
        return;
      }
      if (seatNumber == null ||
          !bus.chair.contains(seatNumber) ||
          bus.chair[bus.chair.indexOf(seatNumber)] == 'rr') {
        print('Invalid seat number.!');
        return;
      }
      bus.chair[bus.chair.indexOf(seatNumber)] = 'rr';

      //30% of the ticket price
      double ticketPrice = 0.3 * trips[index].price.toDouble();
      print('You need to pay ${ticketPrice.toInt()} T for the reservation.');

      stdout.write('Enter the amount you want to pay: ');
      String? paymentInput = stdin.readLineSync();
      if (paymentInput == '0') {
        return;
      }
      int? payment = int.tryParse(paymentInput!);
      if (payment == null || payment != ticketPrice) {
        print('Invalid payment amount. Booking failed.');
        bus.chair[bus.chair.indexOf(seatNumber)] = seatNumber;
        return;
      }

      // income += payment;
      print('Ticket booked successfully. ✔');
      showSeats(bus);
    } catch (e) {
      print('Input invalid!');
    }
  }

//-Void BuyTicket
  void buyTicket() {
    try {
      if (trips.isEmpty) {
        print('There are no trips available for purchase.!');
        return;
      }
      print('Choose a trip to buy a ticket: ');
      displayTrips();
      String? indexTrip = stdin.readLineSync();
      if (indexTrip == '0') {
        return;
      }
      if (indexTrip == null || indexTrip.isEmpty) {
        print('Invalid input.!');
        return;
      }
      int index = int.parse(indexTrip) - 1;
      if (index < 0 || index >= trips.length) {
        print('Invalid input.!');
        return;
      }
      Bus bus = buses[index];
      showSeats(bus);
      stdout.write('Enter the number of the seat you want to buy: ');
      String? seatNumber = stdin.readLineSync();
      if (seatNumber == '0') {
        return;
      }
      if (seatNumber == null ||
          !bus.chair.contains(seatNumber) ||
          bus.chair[bus.chair.indexOf(seatNumber)] == 'bb') {
        print('Invalid seat number.!');
        return;
      }
      bus.chair[bus.chair.indexOf(seatNumber)] = 'bb';

      //100% of the ticket price
      int totalPrice = trips[index].price;
      print('Total price for the ticket: ${totalPrice} T');

      stdout.write('Enter the amount you want to pay: ');
      String? paymentInput = stdin.readLineSync();
      if (paymentInput == '0') {
        return;
      }
      int? payment = int.tryParse(paymentInput!);
      if (payment == null || payment != totalPrice) {
        print('Invalid payment amount. Purchase failed.');
        bus.chair[bus.chair.indexOf(seatNumber)] = seatNumber;
        return;
      }

      // income += payment;
      print('The ticket was successfully purchased. ✔');
      showSeats(bus);
    } catch (e) {
      print('Input invalid!');
    }
  }

//-Void CancelTicket
  void cancelTicket() {
    try {
      if (trips.isEmpty) {
        print('List trip is empty.!');
        return;
      }
      print('Choose a trip to cancel a ticket: ');
      displayTrips();
      String? indexTrip = stdin.readLineSync();
      if (indexTrip == '0') {
        return;
      }
      if (indexTrip == null || indexTrip.isEmpty) {
        print('Invalid input.!');
        return;
      }
      int index = int.parse(indexTrip) - 1;
      if (index < 0 || index >= trips.length) {
        print('Invalid input.!');
        return;
      }
      Bus bus = buses[index];
      showSeats(bus);
      stdout.write('Enter the number of the seat you want to cancel: ');
      String? seatNumber = stdin.readLineSync();
      if (seatNumber == '0') {
        return;
      }
      int chairNum = int.parse(seatNumber!);
      if (seatNumber.isEmpty ||
          seatNumber == null ||
          bus.chair.contains(seatNumber)) {
        print('Invalid seat number.!');
        return;
      }
      int seatIndex = chairNum - 1;
      if ((trips[index].bus.chair[seatIndex]) == 'rr') {
        print(
            '${(trips[index].price) - (((trips[index].price) * 20) / 100)} will be returned to you.!');
        cancelReservation++;
        income += ((((trips[index].price) * 30) / 100) * 20 / 100);
        bus.chair[seatIndex] = seatNumber;
        print('The ticket was successfully cancelled. ✔');
      } else if ((trips[index].bus.chair[seatIndex]) == 'bb') {
        print(
            '${(trips[index].price) - (((trips[index].price) * 10) / 100)} will be returned to you.!');
        cancelBuy++;
        income += (((trips[index].price) * 10) / 100);
        bus.chair[seatIndex] = seatNumber;
        print('The ticket was successfully cancelled. ✔');
        print('$cancelBuy');
        print('$income');
      } else {
        print('This seat was not previously reserved or purchased.');
      }
      showSeats(bus);
    } catch (e) {
      print('Input invalid!');
    }
  }

//-Void TripReport
  void tripReport() {
    if (trips.isEmpty) {
      print('List trip is empty.!');
      return;
    }
    print('Choose a trip to report: ');
    displayTrips();
    String? indexTrip = stdin.readLineSync();
    if (indexTrip == '0') {
      return;
    }
    if (indexTrip == null || indexTrip.isEmpty) {
      print('Invalid input.!');
      return;
    }
    int index = int.parse(indexTrip) - 1;
    if (index < 0 || index >= trips.length) {
      print('Invalid input.!');
      return;
    }

    for (int i = 0; i < trips[index].bus.chair.length; i++) {
      if (trips[index].bus.chair[i] != 'rr' &&
          trips[index].bus.chair[i] != 'bb') {
        emptyChair++;
      }
    }

    print('Trip Report:');
    print('Trip: ${trips[index].origin} to ${trips[index].destination}');
    print('-----------------------------------------');
    print('Income: $income T');
    print('Empty Chairs: $emptyChair');
    print('Canceled Reservations: $cancelReservation');
    print('Canceled Buys: $cancelBuy');
  }
}

//-Void Menu
void menu() {
  print('You can cancel and return to the menu by entering (0) in all steps.');
  print(
      '1.Create Bus, 2.Create Trip, 3.Display Trips, 4.Book Ticket, 5.Buy Ticket, 6.Cancel Ticket, 7.Trip Report, 8.Exit');
}

//-Void Main
void main() {
  Terminal t = Terminal();
  while (true) {
    menu();
    String? input = stdin.readLineSync();
    switch (input) {
      case '1':
        t.createBus();
        break;
      case '2':
        t.createTrip();
        break;
      case '3':
        t.displayTrips();
        break;
      case '4':
        t.bookTicket();
        break;
      case '5':
        t.buyTicket();
        break;
      case '6':
        t.cancelTicket();
        break;
      case '7':
        t.tripReport();
        break;
      case '8':
        print('Exit! code 0 = No error!');
        exit(0);
      default:
        print('Input invalid.Please enter options.');
    }
  }
}
