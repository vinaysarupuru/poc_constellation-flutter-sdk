import 'dart:convert';

/// Represents various actions that can be performed using the Constellation SDK.
abstract class ConstellationSdkAction {
  String get type;
  Map<String, dynamic> toJson();

  String toJsonString() => jsonEncode(toJson());
}

/// Action to create a new case.
class CreateCaseAction extends ConstellationSdkAction {
  @override
  final String type = 'CreateCase';

  final String caseClassName;
  final Map<String, dynamic>? startingFields;

  CreateCaseAction({
    required this.caseClassName,
    this.startingFields,
  });

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'caseClassName': caseClassName,
    if (startingFields != null) 'startingFields': startingFields,
  };
}

/// Action to open an existing assignment.
class OpenAssignmentAction extends ConstellationSdkAction {
  @override
  final String type = 'OpenAssignment';

  final String assignmentId;

  OpenAssignmentAction({required this.assignmentId});

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'assignmentId': assignmentId,
  };
}
