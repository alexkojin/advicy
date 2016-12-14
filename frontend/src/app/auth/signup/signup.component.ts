import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';

import { AuthService } from '../auth.service';
import { UserService } from '../../users/user.service';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html'
})
export class SignupComponent {
  user = {
    username: '',
    email: '',
    password: ''
  };

  error: '';

  constructor(
    private authService: AuthService,
    private userService: UserService,
    private router: Router) {}

  onSubmit(form: NgForm) {
    if(form.valid) {
      this.userService.createUser({user: form.value})
        .subscribe(
          data => {
            this.authService.redirectToBackOrDefault();
          },
          error => {
            this.error = error.json().errors;
          });
    }
  }

}
