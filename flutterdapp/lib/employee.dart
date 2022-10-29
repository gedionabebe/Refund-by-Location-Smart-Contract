import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import "package:flutter/widgets.dart";
import 'package:flutterdapp/Encrypt-Decrypt.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';



class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => EmployeeState();
}
class EmployeeState extends State<Employee>  {
  
  
  final addressController = TextEditingController();
  late Client httpClient = Client();
  late Web3Client  client = Web3Client(
        "192.168.22.228:7545",httpClient);
  late EthPrivateKey credentials = EthPrivateKey.fromHex(
        "14b9f511bbdfb2e8cac49634dcf6a7ad6a6eb174969919a851d9ec1e727f3494");

  late String abi =  rootBundle.loadString("../assets/paybylocation.json") as String;
  late String  contractAddress = "0x9a284DFc776e67232680378337B9Fa3d6c200B4A";
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
        parameters: [lat, lon,DateTime.now().millisecondsSinceEpoch],
        maxGas: 100000,
      ));
    
                    
     },
    child: Text('Submit'),
)
      ],
    );
  }
}