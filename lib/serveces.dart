import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

// class to do the main function add,get,update,delete but i used only 2 get and post idk why :)
class Crud {
  ///Create Read Update Delete
  // used in get function
  getRequest(String url) async {
    var request = await http.get(Uri.parse(url));
    if (request.statusCode == 200) {
      var result = jsonDecode(request.body);
      return result;
    } else {
      return "error to get result";
    }
  }

  Future<String?> fetchUri(Uri url, {Map<String, String>? header}) async {
    try {
      var request = await http.get(url, headers: header);
      if (request.statusCode == 200) {
        var result = jsonDecode(request.body);
        return result;
      } else {
        return "error to get result";
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  // used in post function
  postRequest(String url, Map data) async {
    try {
      var request = await http.post(Uri.parse(url), body: data);
      if (request.statusCode == 201) {
        var result = jsonEncode(request.body.toString());
        return result;
      } else {
        return "error to get result";
      }
    } catch (e) {
      print("error1 $e");
    }
  }

  postRequestWithImage(String url, Map data, File file) async {
    try {
      var prepaireRequest = http.MultipartRequest("POST", Uri.parse(url));
      var imglength = await file.length();
      var imgStream = http.ByteStream(file.openRead());

      var mulPartReqImg = http.MultipartFile("item_img", imgStream, imglength,
          filename: basename(file.path));
      prepaireRequest.files.add(mulPartReqImg);
      data.forEach((key, value) {
        prepaireRequest.fields[key] = value;
      });
      var request = await prepaireRequest.send();
      var response = await http.Response.fromStream(request);
      if (request.statusCode == 200) {
        var result = jsonDecode(response.body.toString());
        return result;
      } else {
        return "error to get result";
      }
    } catch (e) {
      print("error1 $e");
    }
  }

  // used in update function
  putRequest(String url, Map data) async {
    var request = await http.put(Uri.parse(url), body: data);
    if (request.statusCode == 200) {
      var result = jsonDecode(request.body);
      return result;
    } else {
      return "error to get result";
    }
  }

  // used in delete function
  deleteRequest(String url, ) async {
    var request = await http.delete(Uri.parse(url), );
    if (request.statusCode == 200) {
      var result = jsonDecode(request.body);
      return result;
    } else {
      return "error to get result";
    }
  }
}
