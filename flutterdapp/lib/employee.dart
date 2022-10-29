import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import "package:flutter/widgets.dart";
import 'package:flutterdapp/Encrypt-Decrypt.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Employee Page';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}
class _MyCustomFormState extends State<MyCustomForm>  {
  
  
  final addressController = TextEditingController();
  late Client httpClient = Client();
  late Web3Client  client = Web3Client(
        "",httpClient);
  late EthPrivateKey credentials = EthPrivateKey.fromHex(
        "d585835f87981557df21fbaf99df4c9d06fd374b6efd121c027e0655cee5b627");

  late String abi =  rootBundle.loadString("../assets/paybylocation.json") as String;
  late String  contractAddress = "0x4943030bce7e49dd13b4dd120c0fef7dde3c18a0";
  late DeployedContract contract = DeployedContract(ContractAbi.fromJson(abi, "paybylocation"),
        EthereumAddress.fromHex(contractAddress));
  late ContractFunction is_compling = contract.function("is_compling");
  @override
void initState() {
  super.initState();

 
  
  addressController.addListener(() { });

}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Employee Location"),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: addressController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Employee Address',
            ),
          ),
        ),
        
        TextButton(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    ),
    onPressed: () async{
      var position = await Geolocator().getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
      var lat = position.latitude;
      var lon = position.longitude;
     
      await client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: is_compling,
        parameters: [lat, lon],
        maxGas: 100000,
      ));
    
                    
     },
    child: Text('Submit'),
)
      ],
    );
  }
}