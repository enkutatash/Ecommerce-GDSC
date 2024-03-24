import 'package:fire/page/signin.dart';
import 'package:flutter/material.dart';



class ProfilePage extends StatelessWidget {
  Map<String, dynamic> userdata;
  String userid;

  ProfilePage(this.userdata,this.userid,{super.key});
    
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left:20.0,right: 20,top: 70,bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(userdata['profilePic'])
              ),
              Positioned(
                top: 75,
                right: -8,
                child: IconButton(onPressed: (){}, icon:const Icon(Icons.camera_alt_outlined,size: 30,color: Color(0XFF6055D8),)))
              ]
            ),
            const SizedBox(height: 20.0),
            Text(
              userdata['userName'],
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              userdata['Email'],
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20.0),
            NavigationButton(
              text: 'Profile',
              icon: Icons.person,
              showArrowIcon: true,
            ),
            NavigationButton(
              text: 'Settings',
              icon: Icons.settings,
              showArrowIcon: true,
            ),
            NavigationButton(
              text: 'Contact',
              icon: Icons.mail,
              showArrowIcon: true,
            ),
            NavigationButton(
              text: 'Share App',
              icon: Icons.share,
              showArrowIcon: true,
            ),
            NavigationButton(
              text: 'Help',
              icon: Icons.help,
              showArrowIcon: true,
            ),
            
            const Spacer(),
            SizedBox(
              width: width*0.4,
              child: ElevatedButton(
                        onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn_Screen()),
                    );
                        },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF6055D8)),
                  child:const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white),
                  ), // Add your button text here
                ),
            ),
           
          ],
        ),
      ),
    );
  }
}

class BottomIconButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onPressed;

  const BottomIconButton({
    Key? key,
    required this.icon,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: isActive ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool showArrowIcon;

  const NavigationButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.showArrowIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: showArrowIcon ? Icon(Icons.arrow_forward_ios) : null,
    );
  }
}