// Global variables that are accessed and used accross the app
import 'package:vote/services/blockchain/contract_linker.dart';
import 'package:logger/logger.dart';

class Global {
  static late ContractLinker
      linker; // Contract Linker for connection and communication b/w the blockchain
  static Logger logger = Logger(); // Logger for loggin purpose
  static String? userName; // The name of the user
  static int? userId; // The name of the user id (UID)
}
