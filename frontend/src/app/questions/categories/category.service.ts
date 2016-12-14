import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Rx';
import { environment } from '../../../environments/environment';

@Injectable()
export class CategoryService {
  constructor(private http: Http) { }

  getCategories(): Observable<any> {
    return this.http.get(`${environment.API_URL}/categories.json`)
      .map((response: Response) => response.json());
  }

  getTopCategories(limit: number): Observable<any> {
    return this.http.get(`${environment.API_URL}/categories.json?limit=${limit}`)
      .map((response: Response) => response.json());
  }
}
