import 'package:etakesh_client/DAO/Rest_dt.dart';
import 'package:etakesh_client/Models/commande.dart';

abstract class CoursesContract {
  void onLoadingSuccess(List<CommandeDetail> ncmds, List<CommandeDetail> ocmds);
  void onLoadingError();
  void onConnectionError();
}

class CoursesPresenter {
  CoursesContract _view;

  RestDatasource api = new RestDatasource();

  CoursesPresenter(this._view);

  loadCmd(String token, int clientId) {
    api.getNewCmdClient(token, clientId).then((List<CommandeDetail> ncmds) {
      api.getOldCmdClient(token, clientId).then((List<CommandeDetail> ocmds) {
        _view.onLoadingSuccess(ncmds, ocmds);
      });
    }).catchError((onError) {
      _view.onConnectionError();
    });
  }
}
