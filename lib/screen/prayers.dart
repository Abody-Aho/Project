import 'package:flutterfire/screen/tsbeh.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'al_masi.dart';
import 'al_sabh.dart';

class Prayers extends StatelessWidget {
  const Prayers({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF5EF),
      appBar: AppBar(title: Text("الاذكار"),centerTitle: true,),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/5.png'),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 130),
                    buildIslamicCard(
                      context,
                      title: "أذكار المساء",
                      icon: Icons.nightlight_round,
                      color: Colors.indigo,
                      destination: const Masi(),
                    ),
                    buildIslamicCard(
                      context,
                      title: "أذكار الصباح",
                      icon: Icons.wb_sunny,
                      color: Colors.orange,
                      destination: const Sabh(),
                    ),
                    buildIslamicCard(
                      context,
                      title: "التسبيح",
                      icon: Iconsax.repeat_circle,
                      color: Colors.green,
                      destination: const TsbehPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIslamicCard(BuildContext context,
      {required String title,
        required IconData icon,
        required Color color,
        required Widget destination}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Card(
        elevation: 5,
        shadowColor: color.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => destination));
          },
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        ),
      ),
    );
  }
}