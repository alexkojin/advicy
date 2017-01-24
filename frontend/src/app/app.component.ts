
import { Component, AfterViewInit } from '@angular/core';
import { Angulartics2GoogleAnalytics } from 'angulartics2';

import { AuthService } from './auth/auth.service';
import { environment } from '../environments/environment';


declare var jQuery: any;
declare var ga: any;

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements AfterViewInit {
  constructor(
    public auth: AuthService,
    angulartics2GoogleAnalytics: Angulartics2GoogleAnalytics) {}

  ngAfterViewInit() {
    // Initialize foundation framework
    jQuery(document).foundation();

    // Disabling autoDiscover, otherwise Dropzone will try to attach twice.
    Dropzone.autoDiscover = false;

    // Initialize Google Analytics
    if(environment.GOOGLE_ANALYTICS_ENABLED) {
      ga('create', environment.GOOGLE_ANALYTICS_ID, 'auto');
    }
  }
}
