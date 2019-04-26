import 'package:etakesh_client/DAO/Rest_dt.dart';
import 'package:etakesh_client/Models/clients.dart';

abstract class LoginContract {
  void onLoginSuccess(ClientLognin dataloglin);
  void onLoginError();
  void onConnectionError();
}

class LoginPresenter {
  LoginContract _view;
  RestDatasource api = new RestDatasource();
  LoginPresenter(this._view);

  doLogin(String email, String password) {
    api.login(email, password).then((ClientLognin dataloglin) {
      if (dataloglin != null) {
        print("dataclient " + dataloglin.toString());
        _view.onLoginSuccess(dataloglin);
      } else
        _view.onConnectionError();
    }).catchError((onError) {
      _view.onLoginError();
    });
  }
}
