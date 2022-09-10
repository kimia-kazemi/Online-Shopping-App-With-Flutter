import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';
import '../models/user_model.dart';


class CardPreferences {
  static  SharedPreferences? _preferences;
  static const _keyCard = 'card';
  static  CardModel myCard = CardModel(id: 0, brand: "your brand", name: "your name", price: "your price", imageLink: "your image");

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    // _preferences?.clear();
  }

  static Future setCard(CardModel card) async {
    final json = jsonEncode(card.toJson());
    await _preferences?.setString(_keyCard, json);
  }

  static CardModel getCard() {
    final json = _preferences?.getString(_keyCard);
    return json == null ? myCard : CardModel.fromJson(jsonDecode(json));
  }
}
