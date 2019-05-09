import 'package:etakesh_client/DAO/Rest_dt.dart';
import 'package:etakesh_client/Database/DatabaseHelper.dart';
import 'package:etakesh_client/Models/clients.dart';

abstract class LoginContract {
  void onLoginSuccess(Client1 dataclient);
  void onLoginError();
  void onConnectionError();
}

abstract class ParameterContract {
  void onLoardSuccess(Client1 dataclient);
  void onLoginError();
}

class ParameterPresenter {
  ParameterContract _view;
  ParameterPresenter(this._view);
  datasClient() {
    DatabaseHelper().getClient().then((Client1 c) {
      if (c != null) {
        print("CLIENT " + c.client_id.toString());
        _view.onLoardSuccess(c);
      } else {
        _view.onLoginError();
      }
    });
  }
}

class LoginPresenter {
  LoginContract _view;
  RestDatasource api = new RestDatasource();
  LoginPresenter(this._view);

  detailClient(int iduser, String token) {
    api.getClient(iduser, token).then((Client1 dataclient) {
      if (dataclient != null) {
        print("dataclient " + dataclient.toString());
        _view.onLoginSuccess(dataclient);
      } else {
        _view.onLoginError();
      }
    }).catchError((onError) {
      _view.onConnectionError();
    });
  }
}
