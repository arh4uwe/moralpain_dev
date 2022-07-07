import 'dart:io';
import 'package:admin/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:uuid/uuid.dart';

part 'submissions_state.dart';
part 'submissions_event.dart';

class SubmissionsBloc extends Bloc<SubmissionsEvent, SubmissionsState> {
  final log = Logger('SubmissionsBloc');
  final uuid = Uuid();

  final ApiRepository repository;

  SubmissionsBloc({required this.repository}) : super(SubmissionsState()) {
    on<SubmissionsLoadEvent>(_onLoad);
  }

  void _onLoad(
    SubmissionsLoadEvent event,
    Emitter<SubmissionsState> emit,
  ) async {
    emit(state.copyWith(
      submissionsStatus: SubmissionsStatus.loading,
      surveyStatus: SubmissionsStatus.loading,
    ));

    Submissions submissions;
    try {
      submissions = await repository.fetchSubmissions(
        starttime: event.starttime,
        endtime: event.endtime,
        minscore: event.minscore,
        maxscore: event.maxscore,
      );
      emit(state.copyWith(
        submissionsStatus: SubmissionsStatus.success,
        submissions: submissions,
      ));
    } catch (_) {
      emit(state.copyWith(submissionsStatus: SubmissionsStatus.failure));
    }

    Survey survey;
    try {
      // fetch survey from API
      survey = await repository.fetchSurvey();
      emit(state.copyWith(
        surveyStatus: SubmissionsStatus.success,
        survey: survey,
      ));
    } catch (_) {
      // fetch local survey instead
      try {
        survey = await repository.fetchLocalSurvey();
        emit(state.copyWith(
          surveyStatus: SubmissionsStatus.success,
          survey: survey,
          localSurveyFetched: true,
        ));
      } catch (_) {
        // failed to get any survey!
        emit(state.copyWith(surveyStatus: SubmissionsStatus.failure));
      }
    }
  }
}
