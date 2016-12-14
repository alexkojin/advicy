import { Component, OnInit, Input } from '@angular/core';

import { AuthService } from '../../auth/auth.service';
import { FlagService } from './flag.service';

@Component({
  selector: 'app-flag-button',
  template: `
    <a class="flag-button fi-flag" (click)="onClick()" *ngIf="authService.isLoggedIn()"></a>
   `,
  styleUrls: ['./flag-button.component.scss']
})
export class FlagButtonComponent implements OnInit{
  @Input() flaggableType: string;
  @Input() flaggable: any;

  constructor(
    private authService: AuthService,
    private flagService: FlagService) { }

  ngOnInit() {
  }

  onClick() {
    this.flagService.openFlagModal(this.flaggable.id, this.flaggableType);
  }

}
