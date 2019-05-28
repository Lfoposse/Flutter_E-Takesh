import 'package:etakesh_client/DAO/Rest_dt.dart';
import 'package:etakesh_client/Models/commande.dart';

abstract class CoursesContract {
  void onLoadingSuccess(List<CommandeDetail> cmds);
  void onLoadingError();
  void onConnectionError();
}

class CoursesPresenter {
  CoursesContract _view;

  RestDatasource api = new RestDatasource();

  CoursesPresenter(this._view);

  loadCmd(String token, int clientId) {
    api.getCmdClient(token, clientId).then((List<CommandeDetail> cmds) {
      print(cmds);
      if (cmds != null) {
        _view.onLoadingSuccess(cmds);
      } else
        _view.onLoadingError();
    }).catchError((onError) {
      _view.onConnectionError();
    });
  }
}
