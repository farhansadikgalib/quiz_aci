// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  int? success;
  List<Datum>? data;
  String? message;
  String? examid;
  int? duration;
  String? examStartTime;
  String? currTime;
  String? examInterval;
  String? examDuration;
  int? businessId;
  String? examFinishTime;
  String? userid;

  LoginResponse({
    this.success,
    this.data,
    this.message,
    this.examid,
    this.duration,
    this.examStartTime,
    this.currTime,
    this.examInterval,
    this.examDuration,
    this.businessId,
    this.examFinishTime,
    this.userid,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
    examid: json["examid"],
    duration: json["duration"],
    examStartTime: json["ExamStartTime"],
    currTime: json["CurrTime"],
    examInterval: json["ExamInterval"],
    examDuration: json["ExamDuration"],
    businessId: json["BusinessId"],
    examFinishTime: json["ExamFinishTime"],
    userid: json["userid"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "examid": examid,
    "duration": duration,
    "ExamStartTime": examStartTime,
    "CurrTime": currTime,
    "ExamInterval": examInterval,
    "ExamDuration": examDuration,
    "BusinessId": businessId,
    "ExamFinishTime": examFinishTime,
    "userid": userid,
  };
}

class Datum {
  String? examId;
  String? sbuId;
  String? quizSegmentsId;
  String? portfolio;
  String? questionId;
  String? title;
  String? details;
  String? questionDescriptionId;
  String? rightAnswer;
  String? questionType;
  String? imageQuestion;
  String? imageQuestionRaw;
  String? active;
  List<QuestionOption>? questionOption;

  Datum({
    this.examId,
    this.sbuId,
    this.quizSegmentsId,
    this.portfolio,
    this.questionId,
    this.title,
    this.details,
    this.questionDescriptionId,
    this.rightAnswer,
    this.questionType,
    this.imageQuestion,
    this.imageQuestionRaw,
    this.active,
    this.questionOption,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    examId: json["ExamId"],
    sbuId: json["SBUId"],
    quizSegmentsId: json["QuizSegmentsId"],
    portfolio: json["Portfolio"],
    questionId: json["QuestionId"],
    title: json["Title"],
    details: json["Details"],
    questionDescriptionId: json["QuestionDescriptionID"],
    rightAnswer: json["RightAnswer"],
    questionType: json["QuestionType"],
    imageQuestion: json["ImageQuestion"],
    imageQuestionRaw: json["ImageQuestionRaw"],
    active: json["Active"],
    questionOption: json["question_option"] == null ? [] : List<QuestionOption>.from(json["question_option"]!.map((x) => QuestionOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ExamId": examId,
    "SBUId": sbuId,
    "QuizSegmentsId": quizSegmentsId,
    "Portfolio": portfolio,
    "QuestionId": questionId,
    "Title": title,
    "Details": details,
    "QuestionDescriptionID": questionDescriptionId,
    "RightAnswer": rightAnswer,
    "QuestionType": questionType,
    "ImageQuestion": imageQuestion,
    "ImageQuestionRaw": imageQuestionRaw,
    "Active": active,
    "question_option": questionOption == null ? [] : List<dynamic>.from(questionOption!.map((x) => x.toJson())),
  };
}

class QuestionOption {
  String? id;
  String? questionId;
  String? quesOption;
  String? imageQuestionOption;
  String? imageQuestionOptionRaw;
  String? quesValue;

  QuestionOption({
    this.id,
    this.questionId,
    this.quesOption,
    this.imageQuestionOption,
    this.imageQuestionOptionRaw,
    this.quesValue,
  });

  factory QuestionOption.fromJson(Map<String, dynamic> json) => QuestionOption(
    id: json["Id"],
    questionId: json["QuestionId"],
    quesOption: json["QuesOption"],
    imageQuestionOption: json["ImageQuestionOption"],
    imageQuestionOptionRaw: json["ImageQuestionOptionRaw"],
    quesValue: json["QuesValue"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "QuestionId": questionId,
    "QuesOption": quesOption,
    "ImageQuestionOption": imageQuestionOption,
    "ImageQuestionOptionRaw": imageQuestionOptionRaw,
    "QuesValue": quesValue,
  };
}
