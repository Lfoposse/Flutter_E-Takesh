import 'package:etakesh_client/DAO/Rest_dt.dart';
import 'package:etakesh_client/Database/DatabaseHelper.dart';
import 'package:etakesh_client/Models/clients.dart';

abstract class LoginContract {
  void onLoginSuccess(Client client);
  void onLoginError();
  void onConnectionError();
}

class LoginPresenter {
  LoginContract _view;
  RestDatasource api = new RestDatasource();
  LoginPresenter(this._view);

  doLogin(String username, String password, bool checkAccountExists) {
    api.login(username, password, checkAccountExists).then((Client client) {
      if (client != null) {
        new DatabaseHelper().addClient(client);
        _view.onLoginSuccess(client);
      } else
        _view.onLoginError();
    }).catchError((onError) {
      _view.onConnectionError();
    });
  }
}
