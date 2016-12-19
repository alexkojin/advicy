import { Component, EventEmitter, Input, Output } from '@angular/core';

import { Comment } from './comment';
import { CommentService } from './comment.service';
import { AuthService } from '../../auth/auth.service';

@Component({
  selector: 'app-comment-form',
  templateUrl: './comment-form.component.html'
})

export class CommentFormComponent {
  @Input() comment: Comment;
  @Output() onCommentSaved = new EventEmitter<Comment>();
  @Output() onCommentCanceled = new EventEmitter<boolean>();

  constructor(
    private commentService: CommentService,
    private authService: AuthService
    ) { }

  onCancel() {
    this.onCommentCanceled.emit(true);
  }

  onSubmit() {
    this.commentService.updateOrCreateComment(this.comment)
      .subscribe(
        comment => {
          this.onCommentSaved.emit(comment);
        });
  }

}
