import 'package:flutter/material.dart'; // Bu bir kütüphane içe aktarımıdır, ayrı bir dosya değildir.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TFT Şampiyonları',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Inter', // Tailwind CSS'te sıkça kullanılan bir font
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ChampionListPage(),
    );
  }
}

class Champion {
  final String name;
  final String imageUrl; // Şampiyon görselinin URL'si veya asset yolu
  final String description;

  Champion({required this.name, required this.imageUrl, required this.description});
}

class ChampionListPage extends StatefulWidget {
  const ChampionListPage({super.key});

  @override
  State<ChampionListPage> createState() => _ChampionListPageState();
}

class _ChampionListPageState extends State<ChampionListPage> {
  // Bu liste, şampiyon verilerinizi içerecek.
  // Görsel stilini bana tarif ettiğinizde buraya örnek görseller ekleyebiliriz.
  final List<Champion> champions = [
    Champion(
      name: 'Örnek Şampiyon 1',
      imageUrl: 'https://placehold.co/100x100/A0B0C0/FFFFFF?text=Şampiyon1', // Geçici placeholder görsel
      description: 'Bu, örnek şampiyon 1\'in kısa açıklamasıdır.',
    ),
    Champion(
      name: 'Örnek Şampiyon 2',
      imageUrl: 'https://placehold.co/100x100/B0C0D0/FFFFFF?text=Şampiyon2', // Geçici placeholder görsel
      description: 'Bu, örnek şampiyon 2\'nin kısa açıklamasıdır.',
    ),
    Champion(
      name: 'Örnek Şampiyon 3',
      imageUrl: 'https://placehold.co/100x100/C0D0E0/FFFFFF?text=Şampiyon3', // Geçici placeholder görsel
      description: 'Bu, örnek şampiyon 3\'ün kısa açıklamasıdır.',
    ),
    // Buraya daha fazla şampiyon ekleyebilirsiniz.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TFT Şampiyonları',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.blueGrey[50], // Arka plan rengi
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Her satırda 2 şampiyon
              crossAxisSpacing: 16.0, // Yatay boşluk
              mainAxisSpacing: 16.0, // Dikey boşluk
              childAspectRatio: 0.8, // Öğelerin en-boy oranı
            ),
            itemCount: champions.length,
            itemBuilder: (context, index) {
              final champion = champions[index];
              return ChampionCard(champion: champion);
            },
          ),
        ),
      ),
    );
  }
}

class ChampionCard extends StatelessWidget {
  final Champion champion;

  const ChampionCard({super.key, required this.champion});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Yuvarlak köşeler
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // Şampiyon kartına tıklandığında detay sayfasına git
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChampionDetailPage(champion: champion),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Görsel için yuvarlak köşeler
                child: Image.network(
                  champion.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  // Görsel yüklenemediğinde veya hata oluştuğunda gösterilecek placeholder
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                champion.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                champion.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blueGrey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChampionDetailPage extends StatelessWidget {
  final Champion champion;

  const ChampionDetailPage({super.key, required this.champion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          champion.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[800],
        elevation: 0,
      ),
      body: Container(
        color: Colors.blueGrey[50], // Arka plan rengi
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      champion.imageUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    champion.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    champion.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Geri dön
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[600], // Buton rengi
                      foregroundColor: Colors.white, // Yazı rengi
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Geri Dön',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
