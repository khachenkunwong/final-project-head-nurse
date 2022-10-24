import '../app_state.dart';

final url = "https://2e0f-2403-6200-8958-4ca2-dd53-4b82-a1b2-d960.ap.ngrok.io";

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
