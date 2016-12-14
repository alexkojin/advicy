import { Injectable, EventEmitter } from '@angular/core';
import { Observable } from 'rxjs/Rx';

import { AuthHttp } from 'angular2-jwt';
import { ApiService } from '../../api.service';

@Injectable()
export class FlagService extends ApiService  {
  public flagModal = new EventEmitter<any>();

  constructor(private authHttp: AuthHttp) {
    super();
  }

  openFlagModal(flaggableId: number, flaggableType: string) {
    this.flagModal.emit({ flaggable_id: flaggableId, flaggable_type: flaggableType });
  }

  createFlag(flag: any): Observable<any> {
    return this.authHttp.post(`${this.API_URL}/flags`, flag)
      .map(response => response.json());
  }
}
