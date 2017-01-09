import { Component, AfterViewInit } from '@angular/core';

import { AuthService } from './auth/auth.service';


declare var jQuery: any;

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements AfterViewInit {
  constructor(public auth: AuthService) {}

  ngAfterViewInit() {
    jQuery(document).foundation();

    // Disabling autoDiscover, otherwise Dropzone will try to attach twice.
    Dropzone.autoDiscover = false;
  }
}
