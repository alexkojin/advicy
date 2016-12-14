import { Component } from '@angular/core';

import { AuthService } from '../auth.service';

@Component({
  selector: 'app-forgot-password',
  templateUrl: './forgot-password.component.html'
})
export class ForgotPasswordComponent {
  error: string;
  email = "";
  isPasswordSent = false;

  constructor(private authService: AuthService) { }

  onSubmit(email: string) {
    this.email = email;
    this.authService.resetPassword(email).
      subscribe(
        response => {
          this.isPasswordSent = true;
        },
        error => {
          this.error = error.json();
        })
  }

  resetForm() {
    this.error = "";
    this.email = "";
    this.isPasswordSent = false;
  }

}
