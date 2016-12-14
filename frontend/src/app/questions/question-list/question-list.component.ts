import { Component, OnChanges, Input } from '@angular/core';

import { Question } from '../question';
import { QuestionsFilter } from './questions-filter';
import { QuestionService} from '../question.service';

@Component({
  selector: 'app-question-list',
  templateUrl: './question-list.component.html',
  styleUrls: ['./question-list.component.scss']
})
export class QuestionListComponent implements OnChanges {
  questions: Question[] = [];

  @Input() noItemsMessage: string;
  @Input() filter: QuestionsFilter;

  // Pagination
  currentPage = 1;
  totalItems: number;
  itemsPerPage = 10;

  constructor(private questionService: QuestionService) { }

  ngOnChanges() {
    this.getPage(1);
  }

  getPage(page) {
    if(this.filter){
      this.questionService.getFilteredQuestions(this.filter, page)
          .subscribe(data => this.setData(data));
    } else {
      this.questionService.getQuestions(page)
          .subscribe(data => this.setData(data));
    }
  }

  setData(data) {
    this.currentPage = data.current_page;
    this.totalItems = data.total_items;
    this.itemsPerPage = data.per_page;
    this.questions = data.items;
  }

}
