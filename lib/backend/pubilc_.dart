import '../app_state.dart';

final url = "https://3752-2403-6200-8858-f0-adca-27f3-cecb-a592.ap.ngrok.io";

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
