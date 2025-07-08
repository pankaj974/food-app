import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../navigation/navigation_bar.dart';
import '../popular/food_data.dart';
import '../popular/popular_food.dart';
import '../search/search_widget.dart';
import '../target/target_list.dart';
import '../target/target_screen.dart';
import '../widget/support_widget.dart';

class CakeScreen extends StatefulWidget {
  const CakeScreen({super.key});

  @override
  State<CakeScreen> createState() => _CakeScreenState();
}

class _CakeScreenState extends State<CakeScreen> {

  List<bool> isFavorite = [];

  @override
  void initState() {
    super.initState();
    isFavorite = List<bool>.filled(cakeList.length, false);
  }

  void _launchYouTube() async {
    const url = 'https://www.youtube.com/channel/UCtJI-ZZGbSCyFjb5nCYc-iQ';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f3ff),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Cake",
                  style: AppWidget.home1TextFieldStyle(),
                ),
                const SizedBox(height: 10.0),
                searchScreen(),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _launchYouTube,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/cake.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        const Positioned(
                          left: 20,
                          bottom: 20,
                          child: Text(
                            "Special Cake Deals!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Grid of Food Items
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.70,
                  ),
                  itemCount: cakeList.length,
                  itemBuilder: (context, index) {
                    final food = cakeList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TargetScreen(model: CakeItem[index]),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: Image.asset(
                                food['image'],
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          food['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isFavorite[index] = !isFavorite[index];
                                          });
                                          if (isFavorite[index]) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FavoritePage(favoriteFoods: PopularScreen()),
                                              ),
                                            );
                                          }
                                        },
                                        child: Icon(
                                          isFavorite[index]
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFavorite[index] ? Colors.red : Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    food['price'] ?? "\$0.00",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, size: 16, color: Colors.amber),
                                      const SizedBox(width: 4),
                                      Text(
                                        food['rating'] ?? "4.5",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.local_fire_department,
                                          size: 16, color: Colors.orange),
                                      const SizedBox(width: 4),
                                      Text(
                                        food['calories'] ?? "150 Cal",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        food['time'] ?? "20 min",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
