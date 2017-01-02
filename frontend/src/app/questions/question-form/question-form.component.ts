import { Component, OnInit, ViewChild } from '@angular/core';

import { NgForm } from '@angular/forms';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { Observable } from 'rxjs/Rx';

import { MdEditorComponent } from '../../md-editor/md-editor.component';
import { QuestionService } from '../question.service';

import { Question } from '../question';

@Component({
  selector: 'app-question-form',
  templateUrl: './question-form.component.html'
})
export class QuestionFormComponent implements OnInit {
  @ViewChild(MdEditorComponent)
  private descriptionEditor: MdEditorComponent;

  question: Question;

  error: '';

  constructor(
    private questionService: QuestionService,
    private route: ActivatedRoute,
    private router: Router) { }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
      if(params['id']){
        this.questionService.editQuestion(params['id'])
        .subscribe(data => {
          this.question = data;
        });
      } else {
        this.question = new Question();
      }
    });
  }

  getSaveService(form: NgForm): Observable<any> {
    if(this.question.id){
      return this.questionService.updateQuestion(this.question.id, {question: form.value})
    } else {
      return this.questionService.createQuestion({question: form.value});
    }
  }

  onSubmit(form: NgForm) {
    if(form.valid) {
      let description = this.descriptionEditor.getValues();
      form.value.description = description.value;
      form.value.description_html = description.htmlValue;

      this.getSaveService(form)
        .subscribe(question => {
            this.router.navigate(['/questions', question.id, question.slug]);
          },
          error => {
            this.error = error.json();
          });
    }
  }
}
