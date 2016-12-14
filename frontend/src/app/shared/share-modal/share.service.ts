import { Injectable, EventEmitter } from '@angular/core';

@Injectable()
export class ShareService {
  public shareModal = new EventEmitter<string>();

  openShareModal(url: string) {
    this.shareModal.emit(url);
  }
}
