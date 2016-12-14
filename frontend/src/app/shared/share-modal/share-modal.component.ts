import { Component, OnInit, AfterViewInit, EventEmitter } from '@angular/core';

import { ShareService } from './share.service';

declare var jQuery:any;

@Component({
  selector: 'app-share-modal',
  templateUrl: './share-modal.component.html'
})
export class ShareModalComponent implements OnInit, AfterViewInit {

  url: string = '';

  constructor(private shareService: ShareService) { }

  ngOnInit() {
    this.shareService.shareModal.
      subscribe(
        url => {
          this.url = url;
          this.open();
        });
  }

  ngAfterViewInit() {
    // jQuery('#share-modal').foundation();
  }

  open() {
    jQuery('#share-modal').foundation('open');
  }

  close() {
    jQuery('#share-modal').foundation('close');
  }

}
