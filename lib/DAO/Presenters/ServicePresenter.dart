import 'package:etakesh_client/DAO/Rest_dt.dart';
import 'package:etakesh_client/Models/services.dart';

abstract class ServiceContract {
  void onLoadingSuccess(List<Service> service);
  void onLoadingError();
  void onConnectionError();
}

class ServicePresenter {
  ServiceContract _view;

  RestDatasource api = new RestDatasource();

  ServicePresenter(this._view);

  loadTarif() {
    api.getService().then((List<Service> service) {
      print(service);
      if (service != null) {
        _view.onLoadingSuccess(service);
      } else
        _view.onLoadingError();
    }).catchError((onError) {
      _view.onConnectionError();
    });
  }
}
