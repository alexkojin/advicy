import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Rx';
import { AuthHttp } from 'angular2-jwt';

import { Comment } from './comment';
import { ApiService } from '../../api.service';

@Injectable()
export class CommentService extends ApiService {

  constructor(
    private http: Http,
    private authHttp: AuthHttp)
    { super(); }


  updateOrCreateComment(comment: Comment): Observable<any> {
    if(comment.id) {
      return this.updateComment(comment);
    } else {
      return this.createComment(comment);
    }
  }

  createComment(comment: Comment): Observable<any> {
    let body = JSON.stringify({comment: comment});
    return this.authHttp.post(`${this.API_URL}/comments`, body)
      .map((response: Response) => response.json());
  }

  updateComment(comment: Comment): Observable<any> {
    let body = JSON.stringify({comment: comment});
    return this.authHttp.put(`${this.API_URL}/comments/${comment.id}`, body)
      .map((response: Response) => response.json());
  }

  deleteComment(id: number): Observable<any> {
    return this.authHttp.delete(`${this.API_URL}/comments/${id}`)
      .map((response: Response) => response.json());
  }
}
