import { Component, Input } from '@angular/core';

import { Comment } from './comment';
import { CommentService } from './comment.service';
import { AuthService } from '../../auth/auth.service';


@Component({
  selector: 'app-comments',
  templateUrl: './comments.component.html',
  providers: [ CommentService]
})

export class CommentsComponent{
  @Input() isFormOpened: boolean = false;

  @Input() commentableId: any;
  @Input() commentableType: string;
  @Input() comments: Comment[] = [];

  constructor(
    private commentService: CommentService,
    private authService: AuthService
    ) { }

  toggleForm() {
    if(this.authService.isLoggedIn())
      this.isFormOpened = !this.isFormOpened;
    else
      this.authService.openAuthModal();
  }

  onCommentSaved(comment: Comment) {
    this.comments.push(comment);
    this.isFormOpened = false;
  }

  // onSubmit(body: string) {
  //   var comment = new Comment();
  //   comment.body = body;
  //   comment.commentable_id = this.commentableId;
  //   comment.commentable_type = this.commentableType;

  //   this.commentService.createComment(comment)
  //     .subscribe(
  //       comment => {
  //         this.comments.push(comment);
  //         this.isFormOpened = false;
  //       });
  // }

  onCommentDeleted(comment: Comment) {
    var index = this.comments.indexOf(comment);
    this.comments.splice(index, 1);
  }

}
