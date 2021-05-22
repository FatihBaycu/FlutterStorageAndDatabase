class GradeValidator{

  static String checkLessonName(String lessonName){
    if(lessonName.length<1){
      return "Lesson Name length must be high one";
    }
  }

   String checkGradeNumber(String value){
    int grade=int.tryParse(value);
      if (grade < 0 || grade > 100) {
        return "Grade number must be 1 between 100";
    }
    }


  }
