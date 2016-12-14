// Markdown editor
// https://github.com/NextStepWebs/simplemde-markdown-editor

import { Component, Input, ElementRef, ViewChild } from '@angular/core';

var SimpleMDE: any = require('simplemde');

@Component({
  selector: 'app-mdeditor',
  template: `<textarea #simplemde>{{defaultValue}}</textarea>`
})

export class MdEditorComponent {
  @ViewChild('simplemde') textarea: ElementRef;
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
      }
    });
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
