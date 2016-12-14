import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { NgForm } from '@angular/forms';

import { AuthService } from '../auth.service';

@Component({
  selector: 'app-edit-password',
  templateUrl: './edit-password.component.html'
})
export class EditPasswordComponent implements OnInit {
  token: '';
  newPassword: '';

  error: '';

  constructor(
    private route: ActivatedRoute,
    private authService: AuthService) { }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
      this.token = params['token'];
    });
  }

  onSubmit(form: NgForm) {
    this.authService.updatePassword(this.token, this.newPassword)
      .subscribe(
        response => {
          this.authService.navigateToSignIn();
        },
        error => {
          this.error = error.json();
        });

  }

}
