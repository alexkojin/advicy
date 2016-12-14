import { Component, OnInit, OnChanges, Input, AfterViewChecked } from '@angular/core';

declare var jQuery:any;


@Component({
  selector: 'app-share-button',
  templateUrl: './share-button.component.html',
  styleUrls: ['./share-button.component.scss']
})
export class ShareButtonComponent {
  @Input() url: string;
  @Input() text: string = 'Share';

  isOpened: boolean = false;

  constructor() {
    this.url = window.location.href.toString();
  }

  onOpen() {
    this.isOpened = true;

    setTimeout(() => {
      jQuery('#share-modal').foundation().foundation('open');
    });
  }

  onClose() {
    jQuery('#share-modal').foundation('destroy');
  }

  shareFacebook() {
    let url = 'http://www.facebook.com/sharer/sharer.php?u=' +
              encodeURIComponent(this.url || window.location.href.toString())
              + '&text=' + encodeURIComponent(this.text)
              + '&p[summary]='   + encodeURIComponent(this.text);
    this.popup(url);
  }

  shareTwitter() {
    let url = 'https://twitter.com/intent/tweet?url=' +
              encodeURIComponent(this.url || window.location.href.toString())
              + '&text=' + encodeURIComponent(this.text);
    this.popup(url);
  }

  shareGooglePlus() {
    let url = 'https://plus.google.com/share?url=' +
              encodeURIComponent(this.url || window.location.href.toString())
              + '&text=' + encodeURIComponent(this.text);
    this.popup(url);
  }

  popup(url: string) {
    window.open(url,'','toolbar=0,status=0,width=626,height=436');
  }

}
