import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { AuthHttp } from 'angular2-jwt';
import { Observable } from 'rxjs/Rx';

import { Answer } from './answer';
import { ApiService } from '../../api.service';

@Injectable()
export class AnswerService extends ApiService {

  constructor(
    private http: Http,
    private authHttp: AuthHttp)
    { super(); }

  createAnswer(answer: any): Observable<any> {
    let body = JSON.stringify(answer);
    return this.authHttp.post(`${this.API_URL}/answers`, body, { headers: this.contentHeaders })
      .map((response: Response) => response.json());
  }

  editAnswer(id: number): Observable<any> {
    return this.authHttp.get(`${this.API_URL}/answers/${id}/edit`)
      .map((response: Response) => response.json());
  }

  updateAnswer(answer: Answer): Observable<any> {
    let body = JSON.stringify(answer);
    return this.authHttp.put(`${this.API_URL}/answers/${answer.id}`, body)
      .map((response: Response) => response.json());
  }

  deleteAnswer(id): Observable<any> {
    return this.authHttp.delete(`${this.API_URL}/answers/${id}`)
      .map((response: Response) => response.json());
  }
}
