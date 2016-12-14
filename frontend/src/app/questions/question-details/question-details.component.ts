import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { Question } from '../question';
import { QuestionService} from '../question.service';
import { ViewService} from '../../shared/view.service';

@Component({
  selector: 'app-question-details',
  templateUrl: './question-details.component.html'
})

export class QuestionDetailsComponent implements OnInit {
  question: Question;

  constructor(
    private questionService: QuestionService,
    private viewService: ViewService,
    private route: ActivatedRoute,
    private router: Router) {

  }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
      this.questionService.getQuestionDetails(params['id'])
        .subscribe(data => {
          this.question = data;
          this.countView();

          // warkaround to navigate to hashbang after content is loaded
          if(window.location.hash) {
            setTimeout(() => {
              var el = document.querySelector(window.location.hash);
              if(el) el.parentElement.scrollIntoView();
            });
          }

        });
    });
  }

  onDelete() {
    if(confirm('Are you sure want to delete your question?')) {
      this.questionService.deleteQuestion(this.question.id)
        .subscribe(
          response => {
            this.router.navigate(['/']);
          });
    }
  }

  countView() {
    this.viewService.count(this.question.id, 'question')
      .subscribe(response => {});
  }


}
