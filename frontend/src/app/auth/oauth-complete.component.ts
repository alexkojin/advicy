import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { AuthService } from './auth.service';


@Component({
  selector: 'app-oauth-complete',
  template: `OAuth Complete <pre>{{payload}}</pre> `
})
export class OAuthCompleteComponent implements OnInit {

  constructor(
    private authService: AuthService,
    private route: ActivatedRoute,
    private router: Router) { }

  ngOnInit() {
    this.route.queryParams.forEach((params: Params) => {
      var payload = {
        id_token: params['id_token'],
        user: {
          id: params['user_id'],
          username: decodeURIComponent(params['username'].replace(/\+/gm, "%20")),
          slug: params['slug'],
          image_url: params['image_url']
        }
      }

      this.authService.saveToLocalStorage(payload);
      this.authService.redirectToBackOrDefault();
    });
  }

}
