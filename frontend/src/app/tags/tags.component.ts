import { Component, OnInit } from '@angular/core';

import { TagService } from './tag.service';
import { Tag } from './tag';

@Component({
  selector: 'app-tags',
  templateUrl: './tags.component.html',
  styleUrls: ['./tags.component.scss'],
  providers: [TagService],
})
export class TagsComponent implements OnInit {
  tags: Tag[] = [];

  constructor(private tagService: TagService) { }

  ngOnInit() {
    this.tagService.getTags()
      .subscribe(data => this.tags = data.models);
  }
}
