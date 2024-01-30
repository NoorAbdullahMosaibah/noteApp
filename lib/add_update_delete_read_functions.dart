import 'package:db_try1mobapp1/sqldb.dart';

class DatabaseCURD {
  SqlDb sqlDb = SqlDb();

  Future<List<Map>> readData() async {
    List<Map<String, dynamic>> response =
        await sqlDb.readData("SELECT * FROM 'notes'");
    print("fetchData ---------> \n$response");
    return response;
  }

  insert({required String note}) async {
    int response =
        await sqlDb.insertData("INSERT INTO 'notes' ('note') VALUES ('$note')");
    print("add ---------> $response");
  }

  updart({
    required int id,
    required String note,
  }) async {
    int response = await sqlDb
        .updateData("UPDATE 'notes' SET note = '$note' WHERE id = '$id'");
    print("updart ---------> $response");
  }

  delete({required int id}) async {
    int response = await sqlDb.deleteData("DELETE FROM 'notes' WHERE id=$id");
    print("delete ---------> $response");
  }
}
