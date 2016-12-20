import { Component, Input } from '@angular/core';

import { AuthService } from '../../auth/auth.service';
import { VoteService } from './vote.service';

@Component({
  selector: 'app-vote-control',
  template: `
    <div class="vote-control" *ngIf="votable">
      <div class="fa fa-angle-left vote-up " (click)="onVote($event, 1)"></div>
      <div class="vote-count text-center">{{votable.score}}</div>
      <div class="fa fa-angle-right vote-down" (click)="onVote($event, -1)"></div>
    </div>
  `
})
export class VoteControlComponent {
  @Input() votable: any;
  @Input() votableType: 'string';

  constructor(
    private voteService: VoteService,
    private authService: AuthService) { }

  onVote(e:any, value) {
    if(this.authService.isLoggedIn()) {
      this.voteService.sendVote(this.votable.id, this.votableType, value)
        .subscribe(
          data => this.votable.score = data.score
        );
    } else {
      this.authService.openAuthModal();
    }
  }
}
