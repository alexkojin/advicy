import { Component, OnInit } from '@angular/core';

import { AuthService } from '../auth.service';
import { UserService } from '../../users/user.service';
import { User } from '../../users/user.model';

declare var jQuery:any;

@Component({
  selector: 'app-auth-modal',
  templateUrl: './auth-modal.component.html'
})
export class AuthModalComponent implements OnInit {

  guest: User = new User();
  error: string;

  constructor(
    private authService: AuthService,
    private userService: UserService) { }

  ngOnInit() {
    this.authService.authModal.
      subscribe(
        response => {
          setTimeout(() => {
            jQuery('#auth-modal').foundation('open');
          });
        });
  }

  onGuestSubmit() {
    this.userService.createUser({user: this.guest})
      .subscribe(
        data => {
          this.authService.redirectToBackOrDefault();
        },
        error => {
          this.error = error.json().errors;
        });
  }

  close() {
    jQuery('#auth-modal').foundation('close');
  }

}
