import 'package:admin/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:moralpainapi/moralpainapi.dart';

class SubmissionListTile extends StatelessWidget {
  const SubmissionListTile({
    required this.submission,
    this.survey,
    Key? key,
  }) : super(key: key);

  final Submission submission;
  final Survey? survey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: ExpandablePanel(
        header: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            submission.timestamp != null
                ? '${DateTime.fromMillisecondsSinceEpoch(
                    submission.timestamp! * 1000,
                  )}'
                : 'No date for this submission',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        collapsed: Text(''),
        expanded: _summary(),
      ),
    );
  }

  Widget _summary() {
    String text = 'Submission time: ';
    if (submission.timestamp != null) {
      text += DateTime.fromMillisecondsSinceEpoch(
        submission.timestamp! * 1000,
      ).toString();
      text += ' (GMT)';
    } else {
      text += 'not available';
    }
    text += '\n';

    text += 'Score: ';
    if (submission.score != null) {
      text += '${submission.score!} out of 10';
    } else {
      text += 'not available';
    }
    text += '\n';

    text += 'User ID: ';
    text += submission.id ?? 'not available';
    text += '\n';

    text += 'Items selected: ';
    if (submission.selections == null) {
      text += 'not available';
    } else if (submission.selections!.isEmpty) {
      text += 'none selected';
    } else {
      text += submission.selections![0];
      for (int i = 1; i < submission.selections!.length; i++) {
        text += ', ${_decodeSurveySelection(submission.selections![i])}';
      }
    }

    return Text(text);
  }

  String _decodeSurveySelection(String selection) {
    if (survey != null && survey!.sections != null) {
      // Search in the Survey for the given selection code
      for (SurveySection? section in survey!.sections!) {
        if (section != null && section.options != null) {
          for (SurveyOption? option in section.options!) {
            if (option != null && option.id == selection) {
              return option.description ?? selection;
            }
          }
        }
      }
    }

    // If we're at this point, then the Survey doesn't contain the given id.
    return selection;
  }
}
