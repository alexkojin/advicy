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

  private state: string = 'initial';
  private errorMessage: string = '';

  private thumbPreviewTemplate = `
    <div class="dz-preview dz-file-preview">
      <div class="dz-image"><img data-dz-thumbnail /></div>
    </div>`;

  constructor(private authService: AuthService, private elementRef: ElementRef) { }

  ngOnInit() {

  }

  ngAfterViewInit() {
    this.dropzone = new Dropzone('.dropzone', {
      url: environment.API_URL + '/images',
      uploadMultiple: false,
      autoProcessQueue: false,
      thumbnailWidth: 500,
      thumbnailHeight: 250,
      previewTemplate: this.thumbPreviewTemplate,
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
        this.state = 'initial';
        this.close();
      }
    });

    this.dropzone.on('maxfilesreached', (file) => {
      this.state = 'fileAdded';
    });

    this.dropzone.on('error', (file, errorMessage, xhr) => {
      this.state = 'error';
      this.errorMessage = errorMessage;
    });

    this.dropzone.on('reset', () => {
      this.state = 'initial';
    });
  }

  onUpload() {
    this.state = 'uploading';
    this.dropzone.processQueue();
  }

  onRemove() {
    this.dropzone.removeAllFiles();
  }

  open() {
    jQuery('#upload-modal').foundation().foundation('open');
  }

  close() {
    jQuery('#upload-modal').foundation('destroy');
  }

}
