import { Component, Input, AfterViewInit, ElementRef } from '@angular/core';

declare var jQuery:any;

@Component({
  selector: 'app-action-menu',
  template: `
    <a class="action-menu-toggler" [attr.data-toggle]="domId" data-close-on-click="true">
      <i class="fa fa-angle-down"></i>
    </a>
    <div class="small dropdown-pane" [id]="domId" data-dropdown>
      <ul class="no-bullet">
        <ng-content></ng-content>
      </ul>
    </div>
  `,
  styles: [`
    .action-menu-toggler {
      font-size: 1.5rem;
      line-height: 1rem;
    }
  `]

})
export class ActionMenuComponent implements AfterViewInit {
  @Input() id: string;

  get domId(){
    return `action-menu-${this.id}`;
  }

  constructor(private elementRef: ElementRef) { }

  ngAfterViewInit() {
    jQuery(this.elementRef.nativeElement).foundation();
  }

}
