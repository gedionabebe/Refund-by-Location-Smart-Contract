import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import "package:flutter/widgets.dart";
import 'package:flutterdapp/Encrypt-Decrypt.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';


class childModel extends ChangeNotifier {
  bool isLoading = true;
  late Client _httpClient;
  late String _contractAddress;
  late String _abi;
  late Web3Client _client;
  late EthPrivateKey _credentials;
  late DeployedContract _contract;
  late String x;
  late String y;
  late String latitude;
  late String longitude;
  late ContractFunction _readCoordinates;
  late ContractFunction _sendCoordinates;
  childModel() {
    initiateSetup();
  }
  Future<void> initiateSetup() async {
    _httpClient = Client();
    _client = Web3Client(
       "192.168.22.228:7545",
        _httpClient);
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    _abi = await rootBundle.loadString("../assets/paybylocation.json");
    _contractAddress = "0xa0A6D3181DD5dc365121d7479781D4540B608f21";


  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(
        "14b9f511bbdfb2e8cac49634dcf6a7ad6a6eb174969919a851d9ec1e727f3494");

  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abi, "paybylocation"),
        EthereumAddress.fromHex(_contractAddress));
    _readCoordinates = _contract.function("readCoordinates");
    _sendCoordinates = _contract.function("sendCoordinates");
  }

  getCoordinates() async {
    List readCoordinates = await _client
        .call(contract: _contract, function: _readCoordinates, params: []);
    x = readCoordinates[0];
    y = readCoordinates[1];

  }

  addCoordinates(String lat, String lon) async {

    latitude = EncryptionDecryption.encryptAES(lat);
    longitude = EncryptionDecryption.encryptAES(lon);
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _sendCoordinates,
        parameters: [latitude, longitude],
        maxGas: 100000,
      ),
      chainId: 4,
    );


    print("Encrypted Data:");
    print(latitude);
    print(longitude);
    print("Sent Encrypted Data");
    getCoordinates();
    isLoading = false;
    notifyListeners();
  }
}
