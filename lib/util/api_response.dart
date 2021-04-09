
class ApiResponse<T> {

  bool ok;
  String msg;
  T result;
  List<T> entidades;

  ApiResponse.ok(this.result) {
    ok = true;
  }

  ApiResponse.addResponse(this.entidades) {
    ok = true;
  }

  ApiResponse.error(this.msg) {
    ok = false;
  }
}