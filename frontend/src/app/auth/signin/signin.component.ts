import { Component } from '@angular/core';
import { Router } from '@angular/router';

import { AuthService } from '../auth.service';

@Component({
  selector: 'app-signin',
  templateUrl: './signin.component.html'
})
export class SigninComponent {
  error: string;

  constructor(private router: Router, private authService: AuthService) { }

  onLogin(event, email, password) {
    event.preventDefault();

    this.authService.signIn(email, password)
      .subscribe(
        response => {
          this.authService.redirectToBackOrDefault();
        },
        error => {
          this.error = 'Invalid username or password'
        });
  }

}
