import { Headers } from '@angular/http';
import { environment } from '../environments/environment';

export class ApiService {
  protected API_URL: string;
  protected contentHeaders: Headers = new Headers();

  constructor() {
    this.API_URL = environment.API_URL;

    this.contentHeaders.append('Accept', 'application/json');
    this.contentHeaders.append('Content-Type', 'application/json');
  }
}

