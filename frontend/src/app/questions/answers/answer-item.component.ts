import { Component, EventEmitter, Input, Output } from '@angular/core';

import { Answer } from './answer';

@Component({
  selector: 'app-answer-item',
  templateUrl: './answer-item.component.html'
})
export class AnswerItemComponent {
  @Input() answer: Answer;
  @Output() onDelete = new EventEmitter<Answer>();

  getDomId() {
    return `answer-${this.answer.id}`;
  }

  onDeleteClick() {
    if(confirm('Are you sure want to delete your answer?')) {
      this.onDelete.emit(this.answer);
    }
  }
}
