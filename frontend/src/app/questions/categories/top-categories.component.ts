import { Component, OnInit } from '@angular/core';

import { Category } from './category';
import { CategoryService } from './category.service';

@Component({
  selector: 'app-top-categories',
  templateUrl: './top-categories.component.html'
})
export class TopCategoriesComponent implements OnInit {
  categories: Category[] = [];

  constructor(private categoryService: CategoryService) { }

  ngOnInit() {
    this.categoryService.getTopCategories(5)
      .subscribe(data => this.categories = data);
  }

}
