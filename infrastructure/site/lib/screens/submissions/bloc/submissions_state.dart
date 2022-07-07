part of 'submissions_bloc.dart';

enum SubmissionsStatus { initial, loading, success, failure }

class SubmissionsState extends Equatable {
  const SubmissionsState({
    this.submissionsStatus = SubmissionsStatus.initial,
    this.surveyStatus = SubmissionsStatus.initial,
    this.submissions,
    this.survey,
    this.localSurveyFetched = false,
  });

  final SubmissionsStatus submissionsStatus;
  final SubmissionsStatus surveyStatus;
  final Submissions? submissions;
  final Survey? survey;
  final bool localSurveyFetched;

  @override
  List<Object?> get props => [
        submissionsStatus,
        surveyStatus,
        submissions,
        survey,
        localSurveyFetched,
      ];

  SubmissionsState copyWith({
    SubmissionsStatus? submissionsStatus,
    SubmissionsStatus? surveyStatus,
    Submissions? submissions,
    Survey? survey,
    bool? localSurveyFetched,
  }) {
    return SubmissionsState(
      submissionsStatus: submissionsStatus ?? this.submissionsStatus,
      surveyStatus: surveyStatus ?? this.surveyStatus,
      submissions: submissions ?? this.submissions,
      survey: survey ?? this.survey,
      localSurveyFetched: localSurveyFetched ?? this.localSurveyFetched,
    );
  }
}
