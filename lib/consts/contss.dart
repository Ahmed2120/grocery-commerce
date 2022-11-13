import '';
import '../model/category.dart';

class Constss {
  static final List<String> offerImages = [
    'assets/images/offres/Offer1.jpg',
    'assets/images/offres/Offer2.jpg',
    'assets/images/offres/Offer3.jpg',
    'assets/images/offres/Offer4.jpg'
  ];
  static List<String> authImagesPaths = [
    'assets/images/landing/buy-on-laptop.jpg',
    'assets/images/landing/buy-through.png',
    'assets/images/landing/buyfood.jpg',
    'assets/images/landing/grocery-cart.jpg',
    'assets/images/landing/grocery-cart.jpg',
    'assets/images/landing/store.jpg',
    'assets/images/landing/vergtablebg.jpg',
  ];

  static List<Category> catInfo = [
    Category(id: 1,name: 'Fruits', image: 'assets/images/cat/fruits.png'),
    Category(id: 2,name: 'Vegetables', image: 'assets/images/cat/veg.png'),
    Category(id: 3,name: 'Herbs', image: 'assets/images/cat/Spinach.png'),
    Category(id: 4,name: 'Nuts', image: 'assets/images/cat/nuts.png'),
    Category(id: 5,name: 'Spices', image: 'assets/images/cat/spices.png'),
    Category(id: 6,name: 'Grains', image: 'assets/images/cat/grains.png'),
  ];
}
