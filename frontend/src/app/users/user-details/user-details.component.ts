import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';

import { User } from '../user.model';
import { UserService } from '../user.service';

@Component({
  selector: 'app-user-details',
  templateUrl: './user-details.component.html',
  providers: [UserService]
})
export class UserDetailsComponent implements OnInit {
  user: User = new User();

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private userService: UserService) { }

  ngOnInit() {
    this.route.params.forEach((params: Params) => {
      this.userService.getUserDetails(params['id'])
        .subscribe(data => this.user = data);
    });

  }

}
