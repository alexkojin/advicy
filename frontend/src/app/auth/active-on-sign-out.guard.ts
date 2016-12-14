import { Injectable } from '@angular/core';
import { Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { AuthService } from './auth.service';

// Prevent to show signin, signup, forgot.. components when the user is signed in.

@Injectable()
export class ActiveOnSignOutGuard implements CanActivate {
  constructor(
    private router: Router,
    private authService: AuthService) {}

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    return !this.authService.isLoggedIn();
  }
}
