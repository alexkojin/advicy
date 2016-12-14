import { Injectable } from '@angular/core';
import { Response } from '@angular/http';
import { Observable } from 'rxjs/Rx';

import { AuthHttp } from 'angular2-jwt';
import { ApiService } from '../../api.service';

@Injectable()
export class VoteService extends ApiService {

  constructor(private authHttp: AuthHttp) {
    super();
  }

  sendVote(votableId: any, votableType: string, value: number): Observable<any> {
    let body = JSON.stringify({
      votable_id: votableId,
      votable_type: votableType,
      value: value
    });
    return this.authHttp.post(`${this.API_URL}/votes`, body, { headers: this.contentHeaders })
      .map((response: Response) => response.json());
  }

}
