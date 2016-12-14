import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Rx';
import { AuthHttp } from 'angular2-jwt';

import { ApiService } from '../api.service';
import { Question } from './question'
import { QuestionsFilter } from './question-list/questions-filter'

@Injectable()
export class QuestionService extends ApiService {

  constructor(
    private http: Http,
    private authHttp: AuthHttp)
    { super(); }

  getQuestions(page = 1): Observable<any> {
    return this.http.get(`${this.API_URL}/questions.json?page=${page}`)
      .map((response: Response) => response.json());
  }

  getFilteredQuestions(filter: QuestionsFilter, page = 1): Observable<any> {
    let query = [];
    if(filter.name) query.push(`${filter.name}=${filter.value}`);
    if(filter.filter) query.push(`filter=${filter.filter}`);
    query.push(`page=${page}`)

    return this.http.get(`${this.API_URL}/questions.json?${query.join('&')}`)
      .map((response: Response) => response.json());
  }

  getQuestionDetails(id: string): Observable<any> {
    return this.authHttp.get(`${this.API_URL}/questions/${id}.json`)
      .map((response: Response) => response.json());
  }

  getRelatedQuestions(id: string): Observable<any> {
    return this.http.get(`${this.API_URL}/questions/${id}/related_questions`)
      .map((response: Response) => response.json());
  }

  createQuestion(question: any): Observable<any> {
    let body = JSON.stringify(question);
    return this.authHttp.post(`${this.API_URL}/questions`, body)
      .map((response: Response) => response.json());
  }

  editQuestion(id: string): Observable<any> {
    return this.authHttp.get(`${this.API_URL}/questions/${id}/edit`)
      .map((response: Response) => response.json());
  }

  updateQuestion(id: number, question: any): Observable<any> {
    let body = JSON.stringify(question);
    return this.authHttp.put(`${this.API_URL}/questions/${id}`, body)
      .map((response: Response) => response.json());
  }

  deleteQuestion(id: number): Observable<any> {
    return this.authHttp.delete(`${this.API_URL}/questions/${id}`)
      .map((response: Response) => response.json());
  }

}
