import { Component, OnInit, AfterViewInit } from '@angular/core';

import { FlagService } from './flag.service';

declare var jQuery:any;

export interface Flag {
  flaggable_id?: number;
  flaggable_type?: string;
  flag_type?: string;
  reason?: string;
}

@Component({
  selector: 'app-flag-modal',
  templateUrl: './flag-modal.component.html'
})
export class FlagModalComponent implements OnInit, AfterViewInit {

  flag: Flag = {};

  constructor(private flagService: FlagService) { }

  ngOnInit() {
    this.flagService.flagModal.
      subscribe(
        flag => {
          this.flag = flag
          this.open();
        });
  }

  onSubmit() {
    this.flagService.createFlag(this.flag)
      .subscribe(data => {
        this.flag = {};
        this.close();
      });
  }

  ngAfterViewInit() {
    // jQuery('#flag-modal').foundation();
  }

  open() {
    jQuery('#flag-modal').foundation('open');
  }

  close() {
    jQuery('#flag-modal').foundation('close');
  }

}
