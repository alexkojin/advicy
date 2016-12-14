import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { environment } from '../../environments/environment';
import { Observable } from 'rxjs/Rx';

@Injectable()
export class TagService {
  constructor(private http: Http) { }

  getTags(): Observable<any> {
    return this.http.get(`${environment.API_URL}/tags.json`)
      .map((response: Response) => response.json());
  }
}
