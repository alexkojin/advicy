import { Component, OnInit, Input } from '@angular/core';

import { Question } from '../question';
import { QuestionService} from '../question.service';

@Component({
  selector: 'app-related-questions',
  templateUrl: './related-questions.component.html'
})
export class RelatedQuestionsComponent implements OnInit {
  @Input() questionId;
  questions: Question[] = [];

  constructor(private questionService: QuestionService) { }

  ngOnInit() {
    this.questionService.getRelatedQuestions(this.questionId)
      .subscribe(data => this.questions = data);
  }

}
