import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import "package:flutter/widgets.dart";
import 'package:flutterdapp/Encrypt-Decrypt.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';




class Employer extends StatefulWidget {
  const Employer({super.key});

  @override
  State<Employer> createState() => EmployerState();
}
class EmployerState extends State<Employer>  {
  
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final LatitudeController = TextEditingController();
  final LongitudeController = TextEditingController();
  final DistanceController = TextEditingController();
  final TimestampController = TextEditingController();
  late Client httpClient = Client();
  late Web3Client  client = Web3Client(
        "192.168.22.228:7545",httpClient);
  late EthPrivateKey credentials = EthPrivateKey.fromHex(
        "9c225182aeed039eb4c2c0535d3d4522455451a988d4e63f19bef35c608b056f");

  late String abi =  rootBundle.loadString("../assets/paybylocation.json") as String;
  late String  contractAddress = "0x9a284DFc776e67232680378337B9Fa3d6c200B4A";
  late DeployedContract contract = DeployedContract(ContractAbi.fromJson(abi, "paybylocation"),
        EthereumAddress.fromHex(contractAddress));
  late ContractFunction create_employee = contract.function("create_employee");
  @override
void initState() {
  super.initState();

 
  nameController.addListener(() { });
  addressController.addListener(() { });
  LatitudeController.addListener(() { });
  LongitudeController.addListener(() { });
  DistanceController.addListener(() { });
  TimestampController.addListener(() { });
}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Employee Information"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Employee Name',
            ),
          ),
        ),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: LatitudeController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Latitude',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: LongitudeController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Longitude',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: DistanceController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Allowed Distance',
            ),
          ),
        ),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: TimestampController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Allowed Timestamp',
              hintText:'Enter Timestamp in Year,Month,Date Format'
            ),
          ),
        ),
        TextButton(
  style: ButtonStyle(
    
    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    ),
    onPressed: () async{
     List<String> timestamp = TimestampController.text.split(',');
     var mili = DateTime(timestamp[0] as int, timestamp[1] as int, timestamp[2] as int);
      await client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: create_employee,
        parameters: [LatitudeController.text, LongitudeController.text,nameController.text,addressController.text,DistanceController.text,mili],
        maxGas: 100000,
      ));
    
                    
     },
    child: Text('Submit'),
)
      ],
    );
  }
}