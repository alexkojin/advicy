import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { QuestionsFilter } from './question-list/questions-filter';
import { Observable } from 'rxjs/Rx';

@Component({
  selector: 'app-questions',
  templateUrl: './questions.component.html'
})
export class QuestionsComponent implements OnInit {
  questionsFilter: QuestionsFilter = new QuestionsFilter(null, null, null);

  constructor(
    private route: ActivatedRoute,
    private router: Router) { }

  ngOnInit() {
    Observable.zip(
      this.route.params,
      this.route.queryParams
    ).subscribe(
      result => {
        this.setQuestionsFilter(result[0], result[1]);
      }
    );

    this.route.params.forEach((params: Params) => {
      this.setQuestionsFilter(this.route.snapshot.params, params);
    });

    this.route.queryParams.forEach((params: Params) => {
      this.setQuestionsFilter(this.route.snapshot.params, params);
    });
  }

  setQuestionsFilter(params: Params, queryParams: Params) {
    if(params['tag']) {
      this.questionsFilter = new QuestionsFilter('tag', params['tag'], queryParams['filter']);
    }
    else if(params['category']) {
      this.questionsFilter = new QuestionsFilter('category', params['category'], queryParams['filter']);
    }
    else if(params['query']) {
      this.questionsFilter = new QuestionsFilter('query', params['query'], queryParams['filter']);
    }
    else {
      this.questionsFilter = new QuestionsFilter(null, null, queryParams['filter']);
    }
  }

  onFilterNavigate(filter) {
    this.router.navigate([window.location.pathname], {queryParams: {filter: filter}});
  }

}
