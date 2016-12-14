import { Component, Input } from '@angular/core';

import { AuthService } from '../auth/auth.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html'
})
export class HeaderComponent {
  constructor(public auth: AuthService) { }
}
