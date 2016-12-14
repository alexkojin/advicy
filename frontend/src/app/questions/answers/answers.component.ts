import { Component, OnChanges, Input, ViewChild } from '@angular/core';

import { MdEditorComponent } from '../../md-editor/md-editor.component';

import { AnswerService } from './answer.service';
import { AuthService } from '../../auth/auth.service';
import { Question } from '../question';
import { Answer } from './answer';

@Component({
  selector: 'app-answers',
  templateUrl: './answers.component.html'
})
export class AnswersComponent implements OnChanges {
  @ViewChild(MdEditorComponent)
  private editor: MdEditorComponent;

  @Input() question: Question;

  answers: Answer[] = [];

  answer: Answer = new Answer();

  constructor(
    private answerService: AnswerService,
    private authService: AuthService) {}

  ngOnChanges() {
    this.answers = this.question.answers;
    this.answer.question_id = this.question.id;

    // restore a answer after non-authrorized trying to post answer
    if(localStorage.getItem('answer')) {
      var answer = JSON.parse(localStorage.getItem('answer'));
      localStorage.removeItem('answer');
      if(answer.question_id == this.answer.question_id) {
        this.answer = answer;
      }
    }
  }

  onSave() {
    var values = this.editor.getValues();

    if(values.value) {
      this.answer.body = values.value;
      this.answer.body_html = values.htmlValue;


      if(this.authService.isLoggedIn()) {
        this.answerService.createAnswer({answer: this.answer })
          .subscribe(
            answer => {
              this.answers.push(answer);
              this.editor.setValue('');
            });
      } else {
        localStorage.setItem('answer', JSON.stringify(this.answer));
        this.authService.openAuthModal(true);
      }
    }
  }

  onDelete(answer: any) {
    this.answerService.deleteAnswer(answer.id)
      .subscribe(
        response => {
          var index = this.answers.indexOf(answer);
          this.answers.splice(index, 1);
        });
  }

}
