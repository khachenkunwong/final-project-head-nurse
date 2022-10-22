import 'package:hos_windown/backend/pubilc_.dart';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class PostRegisterCall {
  static Future<ApiCallResponse> call({
    required String fristName,
    required String lastName,
    required String email,
    required String password,
  }) {
    final body = '''
{
  "frist_name": "${fristName}",
  "last_name": "${lastName}",
  "email": "${email}",
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postRegister',
      apiUrl: '$url/api/auth/register',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Access-Control_Allow_Origin': '*',
      },
      params: {
        'frist_name': fristName,
        'last_name': lastName,
        'email': email,
        'password': password,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class PostLoginCall {
  static Future<ApiCallResponse> call({
    required String email,
    required String password,
  }) {
    final body = '''
{
  "email": "${email}",
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postLogin',
      apiUrl: '$url/api/auth/login',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Access-Control_Allow_Origin': '*',
      },
      params: {
        'email': email,
        'password': password,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic resToken(dynamic response) => getJsonField(
        response,
        r'''$.token''',
      );
  static dynamic resActor(dynamic response) => getJsonField(
        response,
        r'''$.user.actor''',
      );
    static dynamic resAll(dynamic response) => getJsonField(
        response,
        r'''$.''',
      );
}

class GetProfileCall {
  static Future<ApiCallResponse> call({
    required String token,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getProfile',
      apiUrl: '$url/api/me/profile',
      callType: ApiCallType.GET,
      headers: {
        'content-type': 'application/json',
        'Access-Control_Allow_Origin': '*',
      },
      params: {
        'token': token,
      },
      returnBody: true,
    );
  }

  static dynamic getFristName(dynamic response) => getJsonField(
        response,
        r'''$..frist_name''',
      );
  static dynamic getLastName(dynamic response) => getJsonField(
        response,
        r'''$..last_name''',
      );
  static dynamic getActor(dynamic response) => getJsonField(
        response,
        r'''$..actor''',
      );
  static dynamic getListFullName(dynamic response) => getJsonField(
        response,
        r'''$.data["frist_name","last_name"]''',
      );
}

class CreateTableCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'createTable',
      apiUrl: '$url/api/schedule/create',
      callType: ApiCallType.POST,
      headers: {
        'content-type': 'application/json',
        "Access-Control_Allow_Origin": "*",
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
    );
  }
}

class GetScheduleCall {
  static Future<ApiCallResponse> call({
    required String token,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getSchedule',
      apiUrl: '$url/api/schedule/me/all',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
        'Access-Control_Allow_Origin': '*',
      },
      params: {
        'token': token,
      },
      returnBody: true,
    );
  }

  static dynamic getUser(dynamic response) => getJsonField(
        response,
        r'''$.data[0]._user''',
      );
  static dynamic getSlots(dynamic response) => getJsonField(
        response,
        r'''$.data[0].slots[0]''',
      );
  static dynamic getShift1(dynamic response) => getJsonField(
        response,
        r'''$..shift1''',
      );
  static dynamic getShift2(dynamic response) => getJsonField(
        response,
        r'''$..shift2''',
      );
  static dynamic getShift3(dynamic response) => getJsonField(
        response,
        r'''$..shift3''',
      );
  static dynamic getProfileFristName(dynamic response) => getJsonField(
        response,
        r'''$.._user.frist_name''',
      );
  static dynamic getProfileLastName(dynamic response) => getJsonField(
        response,
        r'''$.._user.last_name''',
      );
  static dynamic getProfile(dynamic response) => getJsonField(
        response,
        r'''$.._user''',
      );
  static dynamic getMySlots(dynamic response) => getJsonField(
        response,
        r'''$..slots[0]["shift1","shift2","shift3"]''',
      );
}

class TestApiCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'testApi',
      apiUrl: '$url/test',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class UpdateProfileCall {
  static Future<ApiCallResponse> call({
    required String token,
    required String fristName,
    required String lastName,
  }) {
    final body = '''
{
  "frist_name": "${fristName}",
  "last_name": "${lastName}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateProfile',
      apiUrl: '$url/api/me/profile',
      callType: ApiCallType.PATCH,
      headers: {
        'content-type': 'application/json',
        'Access-Control_Allow_Origin': '*',
        'x-access-token': '$token',
      },
      params: {
        'frist_name': fristName,
        'last_name': lastName,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class UpdateLeaveApproveCall {
  static Future<ApiCallResponse> call({
    required String token,
    required String id,
    required bool approve,
  }) {
    final body = '''
{
  "requestID": "$id",
  "approve": $approve
}''';
    print("$body");
    return ApiManager.instance.makeApiCall(
      callName: 'updateLeaveApprove',
      apiUrl: '$url/api/req/leader/take/leave/approve',
      callType: ApiCallType.PATCH,
      headers: {
        'content-type': 'application/json',
        'Accept': 'application/json',
        'Access-Control_Allow_Origin': '*',
        'x-access-token': '$token',
      },
      params: {
        "requestID": "$id",
        "approve": approve,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class UpdateApproveCall {
  static Future<ApiCallResponse> call({
    required String token,
    required bool approve,
    required String changId,
  }) {
    final body = '''
{
  "approve": "${approve}",
  "changId": "${changId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateApprove',
      apiUrl: '$url/api/changduty/leader/inprove',
      callType: ApiCallType.PATCH,
      headers: {
        'content-type': 'application/json',
        'Accept': 'application/json',
        'Access-Control_Allow_Origin': '*',
        'x-access-token': '$token',
      },
      params: {
        'approve': approve,
        'changId': changId,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class UpdateSchedule {
  static Future<ApiCallResponse> call() {
    // print("FFAppState().itemsduty22 ${FFAppState().itemsduty}");
    print("กำลังอัพเดต");

    final body = '''{"duties":${FFAppState().itemsduty}}''';
    print("bodyremeber: ${body}");
    return ApiManager.instance.makeApiCall(
      callName: 'updateSchedule',
      apiUrl: '$url/api/schedule/update/schedule',
      callType: ApiCallType.PATCH,
      headers: {
        'content-type': 'application/json; charset=UTF-8',
        'Access-Control_Allow_Origin': '*',
      },
      // params: {
      //   'duties': duties
      // },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic resUpdateSchedule(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class ManageSchedule {
  static Future<ApiCallResponse> call() {
    // print("FFAppState().itemsduty22 ${FFAppState().itemsduty}");
    print("กำลังอัพเดต");

    // final body = '''{"duties":${FFAppState().itemsduty}}''';
    // print("bodyremeber: ${body}");
    return ApiManager.instance.makeApiCall(
      callName: 'updateSchedule',
      apiUrl: '$url/api/schedule/create',
      callType: ApiCallType.POST,
      headers: {
        'content-type': 'application/json; charset=UTF-8',
        'Access-Control_Allow_Origin': '*',
      },
      // params: {
      //   'duties': duties
      // },
      // body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic resUpdateSchedule(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class GetPresentCall {
  static Future<ApiCallResponse> call({
    required String token,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getPresent',
      apiUrl: '$url/api/schedule/me/present',
      callType: ApiCallType.GET,
      headers: {
        'content-type': 'application/json',
        'Access-Control_Allow_Origin': '*',
      },
      params: {
        'token': token,
      },
      returnBody: true,
    );
  }

  static dynamic oneMorning(dynamic response) => getJsonField(
        response,
        r'''$..Duty[0]["morning"]''',
      );
  static dynamic oneNoon(dynamic response) => getJsonField(
        response,
        r'''$..Duty[0].noon''',
      );
  static dynamic oneNight(dynamic response) => getJsonField(
        response,
        r'''$..Duty[0].night''',
      );
  static dynamic listMorning(dynamic response) => getJsonField(
        response,
        r'''$..morning''',
      );
  static dynamic listNoon(dynamic response) => getJsonField(
        response,
        r'''$..noon''',
      );
  static dynamic listNight(dynamic response) => getJsonField(
        response,
        r'''$..night''',
      );
  static dynamic listCount(dynamic response) => getJsonField(
        response,
        r'''$..count''',
      );
  static dynamic listDay(dynamic response) => getJsonField(
        response,
        r'''$..day''',
      );
  static dynamic oneMydata(dynamic response) => getJsonField(
        response,
        r'''$..Duty[0]''',
      );
  static dynamic listMydata(dynamic response) => getJsonField(
        response,
        r'''$..Duty''',
      );
  static dynamic oneListDuty(dynamic response) => getJsonField(
        response,
        r'''$..Duty[0]["morning","noon","night"]''',
      );
  static dynamic oneNameGroup(dynamic response) => getJsonField(
        response,
        r'''$["Duty"]..group''',
      );
}

class GetMyShiftCall {
  static Future<ApiCallResponse> call({
    required String token,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getMyShift',
      apiUrl: '$url/api/schedule/me/present/shift',
      callType: ApiCallType.GET,
      headers: {
        'content-type': 'application/json',
        'Access-Control_Allow_Origin': '*',
      },
      params: {
        'token': token,
      },
      returnBody: true,
    );
  }
}

// ดึงกลุ่มที่กำหนด
class GetMyGroupNameCall {
  static Future<ApiCallResponse> call({
    required String token,
    required String nameGroup,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getMyGroupName',
      apiUrl: '$url/api/schedule/me/present/group/$nameGroup',
      callType: ApiCallType.GET,
      headers: {
        'content-type': 'type application/json',
        'Access-Control_Allow_Origin': '*',
      },
      params: {
        'token': token,
      },
      returnBody: true,
    );
  }

  static dynamic getMyMember(dynamic response) => getJsonField(
        response,
        r'''$..data''',
      );
  static dynamic getNameGroup(dynamic response) => getJsonField(
        response,
        r'''$..title''',
      );
  static dynamic getMessage(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class GetGroupMyMemberCall {
  static Future<ApiCallResponse> call({
    required String token,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getGroupMyMember',
      apiUrl: '$url/api/group/me/member',
      callType: ApiCallType.GET,
      headers: {
        'content-type': 'application/json',
        'Access-Control_Allow_Origin': '*',
      },
      params: {
        'token': token,
      },
      returnBody: true,
    );
  }

  static dynamic getOneMyGroupListLeader(dynamic response) => getJsonField(
        response,
        r'''$..group[0]._leader''',
      );
  static dynamic getOneMyGroupListMember(dynamic response) => getJsonField(
        response,
        r'''$..group[0]._member''',
      );
  static dynamic getMyGroupListNameGroup(dynamic response) => getJsonField(
        response,
        r'''$..name_group''',
      );
  static dynamic getOneMyGroupMemberListEmail(dynamic response) => getJsonField(
        response,
        r'''$..group[0]._member..["email"]''',
      );
  static dynamic getOneMyGroupMemberListFristName(dynamic response) =>
      getJsonField(
        response,
        r'''$..group[0]._member..["frist_name"]''',
      );
  static dynamic getOneMyGroupMemberListLastName(dynamic response) =>
      getJsonField(
        response,
        r'''$..group[0]._member..["last_name"]''',
      );
  static dynamic getListGroup(dynamic response) => getJsonField(
        response,
        r'''$.group[0]''',
      );
  static dynamic getMemberListGroupMember(dynamic response) => getJsonField(
        response,
        r'''$.group[0]._member[0]''',
      );
  static dynamic getLeaderListGroupFristName(dynamic response) => getJsonField(
        response,
        r'''$.group[0]._leader[0]..frist_name''',
      );
  static dynamic getLeaderListGroupLastName(dynamic response) => getJsonField(
        response,
        r'''$.group[0]._leader[0]..last_name''',
      );
  static dynamic getLeaderListGroupEmail(dynamic response) => getJsonField(
        response,
        r'''$.group[0]._leader[0]..email''',
      );
}

class LogoutCall {
  static Future<ApiCallResponse> call({
    required String token,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'logout',
      apiUrl: '$url/api/auth/logout',
      callType: ApiCallType.DELETE,
      headers: {
        'content-type': 'application/json',
      },
      params: {
        'token': token,
      },
      returnBody: true,
    );
  }
}

class GetAllCall {
  static Future<ApiCallResponse> call(
      {required String token, required String nameGroup}) {
    return ApiManager.instance.makeApiCall(
      callName: 'getAll',
      apiUrl: '$url/api/group/schedule/me/all/$nameGroup',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
        'Access-Control_Allow_Origin': '*',
        'x-access-token': '$token',
      },
      params: {},
      returnBody: true,
    );
  }
}

class AutoDutyCall {
  static Future<ApiCallResponse> call({required String groupID}) {
    return ApiManager.instance.makeApiCall(
      callName: 'autoDuty',
      apiUrl: '$url/api/group/create/auto/$groupID',
      callType: ApiCallType.PATCH,
      headers: {
        'content-type': 'application/json',
        'Access-Control_Allow_Origin': '*',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
    );
  }

  static dynamic getState(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class CreateGroupCall {
  static Future<ApiCallResponse> call({
    required String token,
    required String nameGroup,
  }) {
    final body = '''
{
  "name_group": "${nameGroup}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createGroup',
      apiUrl: '$url/api/group/create',
      callType: ApiCallType.POST,
      headers: {
        'content-type': 'application/json',
        'Access-Control_Allow_Origin': '*',
        'x-access-token': '$token',
      },
      params: {
        'name_group': nameGroup,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class AddMemberCall {
  static Future<ApiCallResponse> call({
    required String token,
    required String email,
    required String nameGroup,
  }) {
    final body = '''
{
  "email": "${email}",
  "name_group": "${nameGroup}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addMember',
      // apiUrl: '$url/api/group/addmember',
      apiUrl: "$url/api/invite/invite",
      callType: ApiCallType.POST,
      headers: {
        'content-type': 'application/json',
        'Access-Control_Allow_Origin': '*',
        'x-access-token': '$token',
      },
      params: {
        'email': email,
        'name_group': nameGroup,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
  static dynamic getState(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}
