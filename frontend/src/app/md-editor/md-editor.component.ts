// Markdown editor
// https://github.com/NextStepWebs/simplemde-markdown-editor

import { Component, Input, ElementRef, ViewChild } from '@angular/core';

import { UploadModalComponent } from '../shared/upload-modal/upload-modal.component';

var SimpleMDE: any = require('simplemde');

@Component({
  selector: 'app-mdeditor',
  template: `
    <textarea #simplemde>{{defaultValue}}</textarea>
    <app-upload-modal (onSuccessUpload)="addImage($event)"></app-upload-modal>
  `
})

export class MdEditorComponent {
  @ViewChild('simplemde') textarea: ElementRef;

  @ViewChild(UploadModalComponent) uploadModal: UploadModalComponent;

  @Input() defaultValue: string;
  editor: any;

  constructor(private elementRef:ElementRef) { }

  ngAfterViewInit(){
    this.editor = new SimpleMDE({
      element: this.elementRef.nativeElement.value,
      showIcons: ["code"],
      spellChecker: false,
      renderingConfig: {
        codeSyntaxHighlighting: true
      }// },
      // toolbar: [
      //   "bold", "italic", "strikethrough", "heading", "|", "code", "quote", "unordered-list", "ordered-list",
      //   {
      //     name: "image",
      //     action: this.showUploadImageModal.bind(this),
      //     className: "fa fa-picture-o",
      //     title: "Insert Image",
      //     default: true
      //   },
      // ]
    });

    window.e = this.editor;
  }


  showUploadImageModal(mde: any) {
    this.uploadModal.open();
  }

  addImage(url: string) {
    console.log(url);
    this.editor.codemirror.replaceSelection(`![](${url})`);
  }

  setValue(value: string) {
    this.editor.value(value);
  }

  getValues() {
    return { value: this.editor.value(), htmlValue: this.getHtmlValue() };
  }

  getHtmlValue(): string {
    return this.editor.options.previewRender(this.editor.value());
  }
}
