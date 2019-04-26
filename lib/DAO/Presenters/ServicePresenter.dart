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

  loadServices() {
    api.getService().then((List<Service> services) {
      print(services);
      if (services != null) {
        _view.onLoadingSuccess(services);
      } else
        _view.onLoadingError();
    }).catchError((onError) {
      _view.onConnectionError();
    });
  }
}
