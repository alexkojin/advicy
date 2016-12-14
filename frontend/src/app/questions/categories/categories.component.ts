import { Component, OnInit } from '@angular/core';

import { CategoryService } from './category.service';
import { Category } from './category';

@Component({
  selector: 'app-categories',
  templateUrl: './categories.component.html',
  styleUrls: ['./categories.component.scss']
})
export class CategoriesComponent implements OnInit {
  categories: Category[] = [];

  constructor(private categoryService: CategoryService) { }

  ngOnInit() {
    this.categoryService.getCategories()
      .subscribe(data => this.categories = data);
  }

}
