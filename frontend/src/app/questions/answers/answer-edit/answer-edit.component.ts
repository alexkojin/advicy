import { Component, OnInit, ViewChild } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { MdEditorComponent } from '../../../md-editor/md-editor.component';

import { AnswerService } from '../answer.service';
import { Answer } from '../answer';

@Component({
  selector: 'app-answer-edit',
  templateUrl: './answer-edit.component.html'
})
export class AnswerEditComponent implements OnInit {
  @ViewChild(MdEditorComponent)
  private editor: MdEditorComponent;

  answer: Answer = new Answer();
  questionId: number;
  questionSlug: string;

  constructor(
    private answerService: AnswerService,
    private router: Router,
    private route: ActivatedRoute) { }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
      this.questionId = params['question_id'];
      this.questionSlug = params['question_slug'];

      this.answerService.editAnswer(params['id'])
        .subscribe(data => {
          this.answer = data;
          this.editor.setValue(this.answer.body);
        });
    });
  }

  onSave() {
    var values = this.editor.getValues();

    if(values.value) {
      this.answer.body = values.value;
      this.answer.body_html = values.htmlValue;

      this.answerService.updateAnswer(this.answer)
        .subscribe(
          answer => {
            this.editor.setValue('');
            this.router.navigate(
              ['/questions', this.answer.question_id, this.answer.question_slug],
              { fragment: `a${this.answer.id}`} );
          });
    }
  }

}
