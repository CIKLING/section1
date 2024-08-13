import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Section1Page(),
    );
  }
}

class Section1Page extends StatefulWidget {
  @override
  _Section1PageState createState() => _Section1PageState();
}

class _Section1PageState extends State<Section1Page> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
//untuk mengatur ini konten pada halaman
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Slide(
        image: 'assets/image/slide1.jpg',
        title: 'Gratis Materi Belajar\nMenjadi Seller Handal',
        description:
            'Nggak bisa jualan?\nJangan khawatir, Tokorame akan membimbing kamu\nhingga menjadi seller langsung dari ahlinya',
        pageController: _pageController, // Pass the controller here
        pageIndex: 0,
      ),
      Slide(
        image: 'assets/image/slide2.jpg',
        title: 'Ribuan Produk\ndengan Kualitas Terbaik',
        description:
            'Tokorame menyediakan ribuan produk dengan kualitas\nterbaik dari seller terpercaya',
        pageController: _pageController,
        pageIndex: 1,
      ),
      Slide(
        image: 'assets/image/slide3.jpg',
        title: 'Toko Online Unik\nUntuk Kamu Jualan',
        description: 'Subdomain unik dan toko online profesional\nsiap pakai',
        pageController: _pageController,
        pageIndex: 2,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
          //untuk mengatur tata letak box decoration
          Positioned(
            top: 700,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pages.length, (index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    height: 10.0,
                    width: _currentPage == index ? 50.0 : 15.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Slide extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final PageController pageController;
  final int pageIndex;

  Slide({
    required this.image,
    required this.title,
    required this.description,
    required this.pageController, // Add the controller as a parameter
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 750,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        //untuk mengatur isi konten box decoration
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: 360,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  bottom: 3.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 110,
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (pageIndex < 2) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 200, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      child: const Text(
                        'Selanjutnya',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // mengatur posisi letak 'lewati'
        Positioned(
          top: 70,
          right: 35,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi'),
                    content:
                        const Text('Anda yakin akan melewati halaman ini?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Tidak'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Ya'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Add the action you want to take when "Ya" is pressed
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text(
              'Lewati',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
