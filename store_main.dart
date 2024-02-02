import 'dart:io';

class Products {
  String name;
  int count;
  double price; // example: 2.5

  Products({required this.name, required this.count, required this.price});
}

class MyStore {
  List<Products> products = []; // List Products
  //------------------------create----------------------------
  void create() {
    try {
      stdout.write('Enter name products (0 - cancel): ');
      String? nameProducts = stdin.readLineSync();
      if (nameProducts == '0') {
        return;
      }
      stdout.write('Enter count products (0 - cancel): ');
      String? countProducts = stdin.readLineSync();
      int inputCount = int.parse(countProducts!);
      if (inputCount == 0) {
        return;
      }
      stdout.write('Enter price products (0 - cancel): ');
      String? priceProducts = stdin.readLineSync();
      double inputPrice = double.parse(priceProducts!);
      if (inputPrice == 0) {
        return;
      }

      products.add(
          Products(name: nameProducts!, count: inputCount, price: inputPrice));
      print('(  ✔  )');
    } catch (e) {
      print('Input invalid!');
    }
  }

  //------------------------read----------------------------
  void read() {
    if (products.isEmpty) {
      print('List is empty!');
    } else {
      for (int i = 0; i < products.length; i++) {
        print(
            '${i + 1} ==>> Name: ${products[i].name}, Count: ${products[i].count}, Price: ${products[i].price} T');
      }
    }
  }

  //------------------------update----------------------------
  void update() {
    try {
      read();
      if (products.isEmpty) {
        print('List is empty!');
      } else {
        stdout.write('Enter number products (0 - cancel): ');
        String? indexProductsInput = stdin.readLineSync();
        int? indexProducts = int.parse(indexProductsInput!);
        if (indexProducts == 0) {
          print('cancel!');
          return;
        }
        stdout.write('Enter new name products (0 - cancel): ');
        String? newName = stdin.readLineSync();
        if (newName == '0') {
          return;
        }
        stdout.write('Enter new count products (0 - cancel): ');
        String? newCountProducts = stdin.readLineSync();
        int? newCount = int.parse(newCountProducts!);
        if (newCount == 0) {
          return;
        }
        stdout.write('Enter new price products (0 - cancel): ');
        String? newPriceProducts = stdin.readLineSync();
        double? newPrice = double.parse(newPriceProducts!);
        if (newPrice == 0) {
          return;
        }
        if (newName != null) {
          products[indexProducts - 1].name = newName;
          products[indexProducts - 1].price = newPrice;
          products[indexProducts - 1].count = newCount;
          print('(  ✔  )');
        } else {
          print('Input invalid!');
        }
      }
    } catch (e) {
      print('Input invalid!');
    }
  }

  //------------------------delete----------------------------
  void delete() {
    try {
      read();
      if (products.isEmpty) {
        print('List is empty!');
      } else {
        stdout.write('Enter number products (0 - cancel): ');
        String? inputRemoveProducts = stdin.readLineSync();
        int inputRemove = int.parse(inputRemoveProducts!);
        if (inputRemove > 0) {
          Products remove = products.removeAt(inputRemove - 1);
          print('${remove.name} delete.');
        } else {
          print('cancel!');
        }
      }
    } catch (e) {
      print('Input invalid!');
    }
  }

  //------------------------readOut----------------------------
  void readOutProducts() {
    List<Products> outProducts = products.where((i) => i.count < 5).toList();
    for (Products product in outProducts) {
      print(
          'Name: ${product.name} Count: ${product.count} Price: ${product.price} T');
    }
  }
}

void showMenu() {
  print('1. Create  2. Read  3. Update  4. Delete  5. ReadOut  6. Exit');
}

//------------------------------Main--------------------------------------------
//------------------------------Main--------------------------------------------
//------------------------------Main--------------------------------------------

void main() {
  MyStore store = MyStore(); //New Store
  while (true) {
    showMenu(); //Menu
    String? inputUser = stdin.readLineSync();
    if (inputUser == '1') {
      store.create();
    } else if (inputUser == '2') {
      store.read();
    } else if (inputUser == '3') {
      store.update();
    } else if (inputUser == '4') {
      store.delete();
    } else if (inputUser == '5') {
      store.readOutProducts();
    } else if (inputUser == '6') {
      print('Exit => code 0 = no error ✔');
      exit(0); // code 0 = no error!
    } else {
      print('Input valid!');
    }
  }
}
