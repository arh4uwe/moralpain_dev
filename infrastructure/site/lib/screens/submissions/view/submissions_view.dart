import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/screens/submissions/submissions.dart';
import 'package:moralpainapi/moralpainapi.dart';

class SubmissionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmissionsBloc, SubmissionsState>(
      builder: (context, state) => handleLoadEvents(context, state),
    );
  }

  Widget handleLoadEvents(BuildContext context, SubmissionsState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Submissions'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            submissionsFromState(
              state: state,
              context: context,
            )
          ],
        ),
      ),
    );
  }

  static Widget submissionsFromState({
    required SubmissionsState state,
    required BuildContext context,
  }) {
    switch (state.surveyStatus) {
      case SubmissionsStatus.initial:
      case SubmissionsStatus.loading:
        return Expanded(child: Center(child: CircularProgressIndicator()));
      case SubmissionsStatus.failure:
        SnackBar snackBar = SnackBar(
          content: Text(
            'Error fetching survey! '
            'Some information about the survey responses will be mising.',
          ),
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
        break;
      case SubmissionsStatus.success:
        if (state.localSurveyFetched) {
          SnackBar snackBar = SnackBar(
            content: Text(
              'Error fetching survey from API! '
              'A local copy of the survey is being used instead.',
            ),
          );
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
    }

    switch (state.submissionsStatus) {
      case SubmissionsStatus.initial:
      case SubmissionsStatus.loading:
        return Expanded(child: Center(child: CircularProgressIndicator()));
      case SubmissionsStatus.success:
        if (state.submissions == null) {
          return Expanded(
            child: Center(
              child: Text(
                'Error fetching submissions: '
                'submissions object is null',
              ),
            ),
          );
        } else {
          return Expanded(
            child: Center(
              child: messageFromSubmissions(state.submissions!, state.survey),
            ),
          );
        }
      case SubmissionsStatus.failure:
        return Expanded(
          child: Center(
            child: Text('Error fetching submissions'),
          ),
        );
    }
  }

  static Widget messageFromSubmissions(
    Submissions submissions,
    Survey? survey,
  ) {
    BuiltList<Submission>? list = submissions.list;
    if (list == null) {
      return Text('No list of submissions.');
    }
    if (list.isEmpty) {
      return Text('List of submissions is empty.');
    }
    return CupertinoScrollbar(
      child: ListView(
        children: [
          for (final submission in submissions.list!)
            SubmissionListTile(submission: submission, survey: survey),
        ],
      ),
    );
  }
}
