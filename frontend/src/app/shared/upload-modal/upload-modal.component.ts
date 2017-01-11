import { Component, OnInit, AfterViewInit, ElementRef, EventEmitter, Output} from '@angular/core';

import { environment } from '../../../environments/environment';

import { AuthService } from '../../auth/auth.service';

declare var jQuery:any;

@Component({
  selector: 'app-upload-modal',
  templateUrl: './upload-modal.component.html'
})
export class UploadModalComponent implements OnInit, AfterViewInit {

  private dropzone: any;
  @Output() onSuccessUpload = new EventEmitter<string>();

  constructor(private authService: AuthService, private elementRef: ElementRef) { }

  ngOnInit() {

  }

  ngAfterViewInit() {
    this.dropzone = new Dropzone('.dropzone', {
      url: environment.API_URL + '/images',
      uploadMultiple: false,
      autoProcessQueue: false,
      maxFiles: 1,
      maxFilesize: 2,
      acceptedFiles: 'image/*',
      headers: this.authService.getAuthHeader(),
      maxfilesexceeded: (file) => {
        this.dropzone.removeAllFiles();
        this.dropzone.addFile(file);
      },
      success: (file, response) => {
        this.onSuccessUpload.emit(response['url']);
        this.dropzone.removeFile(file);
      }
    });
  }

  onUpload() {
    this.dropzone.processQueue();
  }

  open() {
    jQuery('#upload-modal').foundation().foundation('open');
  }

  close() {
    jQuery('#upload-modal').foundation('destroy');
  }

}
