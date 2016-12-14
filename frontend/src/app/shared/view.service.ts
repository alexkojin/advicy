import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Rx';
import { AuthHttp } from 'angular2-jwt';

import { ApiService } from '../api.service';

@Injectable()
export class ViewService extends ApiService {

  constructor(private authHttp: AuthHttp) {
    super();
  }

  count(viewableId: number, viewableType: string): Observable<any> {
    let body = JSON.stringify({
      viewable_id: viewableId,
      viewable_type: viewableType
    });
    return this.authHttp.post(`${this.API_URL}/views`, body)
      .map((response: Response) => response.json());
  }
}
