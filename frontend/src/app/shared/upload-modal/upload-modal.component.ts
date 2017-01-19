import { Component, OnInit, AfterViewInit, OnDestroy, ElementRef, EventEmitter, Output} from '@angular/core';

import { environment } from '../../../environments/environment';

import { AuthService } from '../../auth/auth.service';

declare var jQuery:any;

@Component({
  selector: 'app-upload-modal',
  templateUrl: './upload-modal.component.html'
})
export class UploadModalComponent implements OnInit, AfterViewInit, OnDestroy {

  private dropzone: any;
  @Output() onSuccessUpload = new EventEmitter<string>();

  // initial, fileAdded, uploading, error
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
    jQuery(this.elementRef.nativeElement).foundation();

    jQuery(this.elementRef.nativeElement).on('closed.zf.reveal', () => {
      this.state = 'initial';
      this.dropzone.removeAllFiles();
    });

    this.initDropzone();
  }

  initDropzone() {
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

  ngOnDestroy() {
    this.dropzone.destroy();
  }

  onUpload() {
    this.state = 'uploading';
    this.dropzone.processQueue();
  }

  onRemove() {
    this.dropzone.removeAllFiles();
  }

  open() {
    jQuery(this.elementRef.nativeElement).foundation('open');
  }

  close() {
    jQuery(this.elementRef.nativeElement).foundation('close');
  }

}
