// lib/language_notifier.dart
import 'package:flutter/material.dart';

class LanguageNotifier extends ChangeNotifier {
  Locale _currentLocale = const Locale('en'); // Varsayılan İngilizce

  Locale get currentLocale => _currentLocale;

  void changeLanguage(Locale newLocale) {
    if (_currentLocale != newLocale) {
      _currentLocale = newLocale;
      notifyListeners();
    }
  }

  // Uygulamada kullanılabilecek metinleri döndürecek basit bir örnek
  String translate(String key) {
    switch (_currentLocale.languageCode) {
      case 'tr':
        switch (key) {
          case 'settings': return 'Ayarlar';
          case 'language': return 'Dil';
          case 'theme': return 'Tema';
          case 'dark_mode': return 'Koyu Mod';
          case 'light_mode': return 'Açık Mod';
          case 'english': return 'İngilizce';
          case 'turkish': return 'Türkçe';
          case 'download_app': return 'Uygulamayı İndir';
          case 'profile': return 'Profil';
          case 'stats': return 'İstatistikler';
          case 'premium': return 'Premium';
          case 'game_name_tag': return 'Oyun Adı #Etiket';
          case 'search': return 'Ara...';
          case 'explore_set_15': return 'Set 15\'i Keşfet';
          case 'set_arrived': return 'SET 15 GELDİ!';
          case 'explore_details': return 'Tüm yeni şampiyonları, sinerjileri ve eşyaları keşfedin.';
          case 'remove_all_ads': return 'Tüm Reklamları Kaldır';
          case 'ads_description': return 'Reklamlara elveda deyin, ekibimizi destekleyin, özel önizlemeler görün ve yeni Discord rolü edinin.';
          case 'remove_ads_button': return 'REKLAMLARI KALDIR';
          default: return key;
        }
      case 'en':
      default:
        switch (key) {
          case 'settings': return 'Settings';
          case 'language': return 'Language';
          case 'theme': return 'Theme';
          case 'dark_mode': return 'Dark Mode';
          case 'light_mode': return 'Light Mode';
          case 'english': return 'English';
          case 'turkish': return 'Turkish';
          case 'download_app': return 'DOWNLOAD APP';
          case 'profile': return 'Profile';
          case 'stats': return 'Stats';
          case 'premium': return 'Premium';
          case 'game_name_tag': return 'Game Name #Tag';
          case 'search': return 'Search...';
          case 'explore_set_15': return 'EXPLORE SET 15';
          case 'set_arrived': return 'SET 15 HAS ARRIVED!';
          case 'explore_details': return 'Explore all the new champs, synergies, and items on Mobalytics.';
          case 'remove_all_ads': return 'Remove all ads';
          case 'ads_description': return 'Say goodbye to ads, support our team, see exclusive sneak peeks, and get a shiny new Discord role.';
          case 'remove_ads_button': return 'REMOVE ADS';
          default: return key;
        }
    }
  }
}