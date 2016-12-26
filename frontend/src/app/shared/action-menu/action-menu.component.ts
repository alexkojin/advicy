import { Component, Input, AfterViewInit, ElementRef } from '@angular/core';

declare var jQuery:any;

@Component({
  selector: 'app-action-menu',
  template: `
    <a class="action-menu-toggler" [attr.data-toggle]="domId">
      <i class="fa fa-ellipsis-v"></i>
    </a>
    <div class="small dropdown-pane" [id]="domId" data-dropdown data-close-on-click="true">
      <ul class="no-bullet">
        <ng-content></ng-content>
      </ul>
    </div>
  `,
  styles: [`
    .action-menu-toggler {
      font-size: 1rem;
      line-height: 1rem;
    }
  `]

})
export class ActionMenuComponent implements AfterViewInit {
  // id should be unique domId. TODO be sure always set unique id
  @Input() id: string;

  get domId(){
    return `action-menu-${this.id}`;
  }

  constructor(private elementRef: ElementRef) { }

  ngAfterViewInit() {
    jQuery(this.elementRef.nativeElement).foundation();
  }

}
