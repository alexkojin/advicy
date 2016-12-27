import { Component, EventEmitter, Input, Output } from '@angular/core';

import { Comment } from './comment';
import { CommentService } from './comment.service';
import { AuthService } from '../../auth/auth.service';

@Component({
  selector: 'app-comment-item',
  templateUrl: './comment-item.component.html'
})
export class CommentItemComponent {
  @Input() comment: Comment;
  @Output() onCommentDeleted = new EventEmitter<Comment>();
  @Output() onCommentEdit = new EventEmitter<Comment>();

  editModeEnabled = false;

  constructor(
    private commentService: CommentService,
    private authService: AuthService) { }

  getDomId() {
    return `comment-${this.comment.id}`;
  }

  onEdit() {
    this.editModeEnabled = true;
    this.onCommentEdit.emit(this.comment);
  }

  onCommentSaved(comment: Comment) {
    this.editModeEnabled = false;
  }

  onDelete(comment: Comment) {
    if(confirm('Are you sure want to delete this comment?')) {
      this.commentService.deleteComment(comment.id)
        .subscribe(
          response => {
            this.onCommentDeleted.emit(this.comment);
          });
    }
  }

}
