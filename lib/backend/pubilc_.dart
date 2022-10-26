import '../app_state.dart';

final url = "https://373a-2403-6200-8958-4ca2-8850-bb85-f976-490e.ap.ngrok.io";

const productsGraphQL = """
query ExampleQuery {
  notifications {
    _id
  }
}
""";
const deleteGroupGraphQL = r"""
mutation DeleteGroup($input: DeleteGroupInput!) {
  deleteGroup(input: $input)
}
""";

const shownotificationLeave = r"""
query Notifications($filter: JSON) {
  notifications(filter: $filter) {
    type
    _id
    fields
    noift
  }
}
""";
final addporeshownotificationLeave = {
  "filter": {"type": "LEAVE_DUTY", "leader": "${FFAppState().myID}"}
};
const getchangduty = r"""
query Query($filter: JSON) {
  notifications(filter: $filter) {
    _id
    type
    fields
    approve_by {
      frist_name
      last_name
      actor
    }
    noift
    user {
      frist_name
      last_name
    }
  }
}
""";