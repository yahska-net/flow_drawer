import 'package:example/screens/home.dart';
import 'package:example/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:flow_drawer/flow_drawer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlowDrawerExample(),
    );
  }
}

class FlowDrawerExample extends StatefulWidget {
  const FlowDrawerExample({super.key});

  @override
  State<FlowDrawerExample> createState() => _FlowDrawerExampleState();
}

class _FlowDrawerExampleState extends State<FlowDrawerExample> {
  final controller = FlowDrawerController();

  @override
  Widget build(BuildContext context) {
    // Flow Drawer Menu Items or create your own custom widget
    final List<Widget> items = [
      FlowDrawerMenuItem(
        icon: Icon(Icons.home, size: 22, color: Colors.white),
        text: "Home",
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (ctx) => Home())),
        controller: controller,
      ),
      FlowDrawerMenuItem(
        icon: Icon(Icons.verified_user, size: 22, color: Colors.white),
        text: "Security",
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (ctx) => Search())),
        controller: controller,
      ),
      FlowDrawerMenuItem(
        icon: Icon(Icons.search_outlined, size: 22, color: Colors.white),
        text: "Search",
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (ctx) => Home())),
        controller: controller,
      ),
      SizedBox(height: 40),
      FlowDrawerMenuItem(
        icon: Icon(Icons.logout_outlined, size: 22, color: Colors.white),
        text: "Logout",
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (ctx) => Search())),
        controller: controller,
      ),
    ];

    // Flow Drawer
    return FlowDrawer(
      controller: controller,
      drawerItems: items,
      enableTopMenu: true,
      topMenu: FlowTopMenu(
        menuWidth: double.infinity,
        controller: controller,
        leftMenuIcon: Icon(
          Icons.person_2_outlined,
          size: 22,
          color: Colors.white,
        ),
        onRightTap: () => controller.close(),
        rightMenuIcon: Icon(
          Icons.close_outlined,
          size: 22,
          color: Colors.white,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Flow Drawer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
              fontSize: 26,
            ),
          ),
          leadingWidth: 100,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: const Icon(Icons.menu_outlined, color: Colors.white),
                  onPressed: controller.toggle,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 30),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent.shade100,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent.shade100,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
