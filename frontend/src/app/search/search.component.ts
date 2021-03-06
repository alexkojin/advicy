import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-search',
  template: `
    <input class="search-input"
           type="text"
           placeholder="Search Q&A"
           (keyup.enter)="onEnter($event)" />`
})

export class SearchComponent {
  query: string = "";

  constructor(private router: Router) {}

  onEnter(event: any) {
    this.query = event.target.value;
    event.target.value = "";

    this.router.navigate(['/', 'questions', 'search', this.query]);
  }
}
