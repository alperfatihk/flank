import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Kendi projenizin adına göre aşağıdaki import satırlarını düzenleyin
import 'package:my_tft_app/theme_notifier.dart';
import 'package:my_tft_app/language_notifier.dart'
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobalytics TFT UI',
      debugShowCheckedModeBanner: false, // Debug bandını kaldırır
      theme: ThemeData(
        // Mobalytics benzeri koyu tema
        brightness: Brightness.dark, // Koyu tema
        scaffoldBackgroundColor: const Color(0xFF1B1A2E), // Ana arka plan rengi
        cardColor: const Color(0xFF2C2B4B), // Kartların arka plan rengi
        primaryColor: const Color(0xFF6A5ACD), // Ana vurgu rengi (mor tonu)
        hintColor: const Color(0xFFFFA500), // Turuncu vurgu rengi
        textTheme: const TextTheme(
          // Metin stilleri
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          headlineSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B1A2E), // AppBar arka planı
          foregroundColor: Colors.white, // AppBar üzerindeki ikon ve metin rengi
          elevation: 0, // Gölge yok
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2C2B4B), // Arama çubuğunun arka planı
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.white54),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        ),
      ),
      home: const TFTChampionsPage(),
    );
  }
}

// Şampiyon Veri Modeli
class Champion {
  final String name;
  final String imageUrl;
  final List<String> traits; // Özellikler/Sınıflar (Bruiser, AMP, vb.)
  final int cost; // Maliyet

  Champion({
    required this.name,
    required this.imageUrl,
    required this.traits,
    required this.cost,
  });
}

class TFTChampionsPage extends StatefulWidget {
  const TFTChampionsPage({super.key});

  @override
  State<TFTChampionsPage> createState() => _TFTChampionsPageState();
}

class _TFTChampionsPageState extends State<TFTChampionsPage> {
  // Örnek şampiyon verileri
  final List<Champion> _allChampions = [ // Tüm şampiyonları tutan liste
    Champion(
      name: 'Alistair',
      imageUrl: 'assets/images/alistair.jpg',
      traits: ['Golden Ox', 'Bruiser'],
      cost: 1,
    ),
    Champion(
      name: 'Annie',
      imageUrl: 'assets/images/annie.jpg',
      traits: ['Golden Ox', 'A.M.P.'],
      cost: 1,
    ),
    Champion(
      name: 'Aphelios',
      imageUrl: 'assets/images/aphelios.jpg',
      traits: ['Golden Ox', 'Marksman'],
      cost: 4,
    ),
    Champion(
      name: 'Aurora',
      imageUrl: 'assets/images/aurora.jpg',
      traits: ['Astromancer Squad', 'Dynamo'],
      cost: 5,
    ),
    Champion(
      name: 'Teemo',
      imageUrl: 'assets/images/teemo.jpg',
      traits: ['Street Demon', 'Vanguard'],
      cost: 3,
    ),
    Champion(
      name: 'Silas',
      imageUrl: 'assets/images/silas.jpg',
      traits: ['Syndicate', 'Brawler'],
      cost: 2,
    ),
    Champion(
      name: 'Lux',
      imageUrl: 'assets/images/lux.jpg',
      traits: ['BoomBots', 'Bruiser'],
      cost: 3,
    ),
    Champion(
      name: 'Ekko',
      imageUrl: 'assets/images/ekko.jpg',
      traits: ['Syndicate', 'Infiltrator'],
      cost: 4,
    ),
    // Daha fazla şampiyon ekleyebilirsiniz
  ];

  List<Champion> _filteredChampions = []; // Filtrelenmiş şampiyonları tutan liste
  int? _selectedCost; // Seçilen maliyet (null ise tümünü göster)

  @override
  void initState() {
    super.initState();
    _filteredChampions = _allChampions; // Başlangıçta tüm şampiyonları göster
  }

  void _filterChampionsByCost(int? cost) {
    setState(() {
      _selectedCost = cost;
      if (cost == null) {
        _filteredChampions = _allChampions; // Tümünü göster
      } else {
        _filteredChampions = _allChampions.where((champion) => champion.cost == cost).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sol Yan Menü (Mobalytics'teki ikonlar için)
      drawer: const Drawer(
        backgroundColor: Color(0xFF1B1A2E),
        child: Column(
          children: [
            SizedBox(height: 50), // Üst boşluk
            // Mobalytics Logosu veya ikon
            ListTile(
              leading: Icon(Icons.download, color: Colors.white70),
              title: Text('DOWNLOAD APP', style: TextStyle(color: Colors.white)),
            ),
            Divider(color: Colors.white10),
            ListTile(
              leading: Icon(Icons.apps, color: Colors.white70),
              title: Text('SET 14', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.white70),
              title: Text('Profil', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.assessment, color: Colors.white70),
              title: Text('Stats', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.diamond, color: Colors.white70), // Premium için
              title: Text('Premium', style: TextStyle(color: Colors.white)),
            ),
            // Diğer ikonları buraya ekleyebilirsiniz
            Spacer(), // En alta yaslar
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white70),
              title: Text('Ayarlar', style: TextStyle(color: Colors.white)),
              // TODO: Ayarlar sayfasına geçişi burada etkinleştirebilirsiniz
              // onPressed: () {
              //   Navigator.pop(context); // Drawer'ı kapat
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const SettingsPage()), // SettingsPage'i oluşturmanız gerekir
              //   );
              // },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // AppBar yüksekliği
        child: AppBar(
          automaticallyImplyLeading: false, // Varsayılan geri butonunu kaldırır
          title: Row(
            children: [
              Builder(
                // Builder widget'ı ekleyerek Scaffold context'ine erişim sağla
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Drawer'ı açar
                    },
                  );
                },
              ),
              const SizedBox(width: 8),
              // Mobalytics logosu yerine basit bir metin veya ikon
              const Text(
                'MOBALYTICS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              // Oyun Sekmeleri (TFT, LoL, PoE2 vb.)
              _buildGameTab('TFT', selected: true),
              _buildGameTab('LoL'),
              _buildGameTab('PoE2'),
              // Diğer oyun sekmelerini buraya ekleyebilirsiniz
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2B4B),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Game Name #Tag',
                          hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.white54),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.keyboard_alt, color: Colors.white54),
                              SizedBox(width: 8),
                              Icon(Icons.person_outline, color: Colors.white54),
                              SizedBox(width: 8),
                              Icon(Icons.settings_outlined, color: Colors.white54),
                            ],
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.history, color: Colors.white70),
                  const SizedBox(width: 10),
                  const Icon(Icons.login, color: Colors.white70),
                ],
              ),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // En üstteki reklam banner
          SliverToBoxAdapter(
            child: Container(
              color: Colors.deepPurple[800], // Mor banner rengi
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: const Text(
                'Set 15 has been revealed! See all new champs, mechanics, and synergies now. → Explore Set 15',
                style: TextStyle(color: Colors.white, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ortadaki "SET 15 HAS ARRIVED!" banner
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8A2BE2), Color(0xFF4B0082)], // Mor tonları
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/banner_bg.png'), // Arka plan deseni için
                        fit: BoxFit.cover,
                        opacity: 0.2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'TFT SET 15 HAS ARRIVED!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Explore all the new champs, synergies, and items on Mobalytics.',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6A5ACD), // Buton arka planı
                              foregroundColor: Colors.white, // Buton metin rengi
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('EXPLORE SET 15'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Arama ve Sayfalama
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            prefixIcon: const Icon(Icons.search, color: Colors.white54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: const Color(0xFF2C2B4B),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Sayfalama/Maliyet filtreleme butonları
                      Row(
                        children: List.generate(5, (index) {
                          int cost = index + 1;
                          bool isSelected = _selectedCost == cost;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Material(
                              color: isSelected ? Theme.of(context).primaryColor : const Color(0xFF2C2B4B),
                              borderRadius: BorderRadius.circular(8.0),
                              child: InkWell(
                                onTap: () {
                                  _filterChampionsByCost(isSelected ? null : cost); // Seçiliyse tümünü göster, değilse seçili maliyetle filtrele
                                },
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  child: Text(
                                    '$cost', // Maliyet numarasını göster
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 10),
                      // "All" butonu (tüm maliyetleri göstermek için)
                      Material(
                        color: _selectedCost == null ? Theme.of(context).primaryColor : const Color(0xFF2C2B4B),
                        borderRadius: BorderRadius.circular(8.0),
                        child: InkWell(
                          onTap: () {
                            _filterChampionsByCost(null); // Tüm maliyetleri göster
                          },
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Text(
                              'All',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: _selectedCost == null ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Karakter Kartları (GridView)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Her satırda 2 kart
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7, // Kartların en boy oranı
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final champion = _filteredChampions[index]; // Filtrelenmiş listeyi kullan
                  return _buildChampionCard(champion);
                },
                childCount: _filteredChampions.length, // Filtrelenmiş liste sayısını kullan
              ),
            ),
          ),
          // Sağ taraftaki reklam ve "Remove Ads" bölümü (basit bir placeholder)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey[800],
                    alignment: Alignment.center,
                    child: const Text('ADVERTISEMENT', style: TextStyle(color: Colors.white54)),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2B4B),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Remove all ads', style: Theme.of(context).textTheme.titleMedium),
                            const Icon(Icons.close, color: Colors.white54),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Say goodbye to ads, support our team, see exclusive sneak peeks, and get a shiny new Discord role.',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).hintColor, // Turuncu renk
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('REMOVE ADS'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey[800],
                    alignment: Alignment.center,
                    child: const Text('ADVERTISEMENT', style: TextStyle(color: Colors.white54)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Oyun Sekmeleri için yardımcı widget
  Widget _buildGameTab(String title, {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.transparent,
        borderRadius: BorderRadius.circular(5.0),
        border: selected ? Border.all(color: Theme.of(context).primaryColor) : Border.all(color: Colors.white12),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  // Şampiyon Kartı için yardımcı widget
  Widget _buildChampionCard(Champion champion) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.asset(
                champion.imageUrl,
                fit: BoxFit.cover,
                // Resim bulunamazsa veya yüklenmezse gösterilecek yer tutucu
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.grey[700], child: const Icon(Icons.broken_image, color: Colors.white54)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  champion.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4.0,
                  runSpacing: 2.0,
                  children: champion.traits.map((trait) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[700],
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        trait,
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.monetization_on, color: Theme.of(context).hintColor, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${champion.cost}',
                        style: TextStyle(color: Theme.of(context).hintColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}