import { Component, OnInit } from '@angular/core';

import { User } from './user.model';
import { UserService } from './user.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss']
})
export class UsersComponent implements OnInit {
  users: User[] = [];

  query: string;

  // Pagination
  currentPage = 1;
  totalItems: number;
  itemsPerPage = 20;

  constructor(private userService: UserService) { }

  ngOnInit() {
    this.getPage(1);
  }

  getPage(page: number) {
    this.userService.getUsers(page, this.query)
      .subscribe(data => this.setData(data));
  }

  onSearchKeyUp(query: string) {
    this.query = query
    this.getPage(1)
  }

  setData(data) {
    this.currentPage = data.current_page;
    this.totalItems = data.total_items;
    this.itemsPerPage = data.per_page;
    this.users = data.items
  }

}
