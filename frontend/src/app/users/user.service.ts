import { Injectable } from '@angular/core';
import { Http, Headers, Response } from '@angular/http';
import { Observable } from 'rxjs/Rx';
import { environment } from '../../environments/environment';

@Injectable()
export class UserService {
  contentHeaders: Headers = new Headers();

  constructor(private http: Http) {
    this.contentHeaders.append('Accept', 'application/json');
    this.contentHeaders.append('Content-Type', 'application/json');
  }

  getUsers(page: number, query?: string): Observable<any> {
    var params = `page=${page}`;
    if(query) params += `&query=${query}`;

    return this.http.get(`${environment.API_URL}/users.json?${params}`)
      .map((response: Response) => response.json());
  }

  getUserDetails(id: string): Observable<any> {
    return this.http.get(`${environment.API_URL}/users/${id}.json`)
      .map((response: Response) => response.json());
  }

  createUser(user: any): Observable<any> {
    let body = JSON.stringify(user);
    return this.http.post(`${environment.API_URL}/users`, body, { headers: this.contentHeaders })
      .map((response: Response) => response.json());
  }

}
