import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prestige/firebase_options.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/view/authView/splashScreen.dart';
import 'package:prestige/viewModel/authViewModel.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/subCategoryProvider.dart';
import 'package:prestige/viewModel/searchProvider.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.request();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);

     runApp(
     const MyApp(),
  
  );
}
@pragma('vm:entry-point')
Future<void> _onBackgroundMessageHandler(RemoteMessage message)async{
   
  await Firebase.initializeApp();
  if (kDebugMode) {
    print({"notification main :${message.notification!.title.toString()}"});
  }

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SubCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Voice Marker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
             primarySwatch: Colors.teal,
        colorScheme: const ColorScheme.light(
          primary: colorPrimary, // Header background color
          onPrimary: Colors.white, // Header text color
          onSurface: Colors.black, // Body text color
        ),    
         
            useMaterial3: true,
          ),
        home: SplashScreen(),
      ),
    );
  }
}
