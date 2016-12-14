import { Injectable, EventEmitter } from '@angular/core';
import { Http, Headers, Response } from '@angular/http';
import { Router } from '@angular/router';
import { Observable } from 'rxjs/Rx';
import { tokenNotExpired } from 'angular2-jwt';

import { environment } from '../../environments/environment';

import { ApiService } from '../api.service';
import { User } from '../users/user.model';

@Injectable()
export class AuthService extends ApiService {
  // Don't remember these paths for redirect back
  private regexpSkipPathsToRedirectBack: RegExp = /^\/(signin|signup|password|oauth-complete)/;

  public authModal = new EventEmitter<boolean>();

  constructor(private router: Router, private http: Http) {
    super();
  }

  openAuthModal(showGuestForm = false) {
    this.authModal.emit(showGuestForm);
  }

  saveToLocalStorage(data) {
    localStorage.setItem('id_token', data.id_token);
    localStorage.setItem('profile', JSON.stringify(data.user));
  }

  signIn(email, password): Observable<any> {
    let body = JSON.stringify({ email, password });
    return this.http.post(`${this.API_URL}/authenticate`, body, { headers: this.contentHeaders })
      .map(
        (response: Response) => {
          this.saveToLocalStorage(response.json());
        }
      );
  }

  signOut() {
    localStorage.removeItem('id_token');
    localStorage.removeItem('profile');
    this.router.navigate(['/signin']);
  }

  resetPassword(email: string): Observable<any> {
    let body = JSON.stringify({email: email})
    return this.http.post(`${this.API_URL}/passwords`, body, { headers: this.contentHeaders })
  }

  updatePassword(token: string, password: string): Observable<any> {
    let body = JSON.stringify({
      reset_password_token: token,
      password: password,
      password_confirmation: password });

    return this.http.put(`${this.API_URL}/passwords`, body, { headers: this.contentHeaders })
  }

  isLoggedIn() {
    return tokenNotExpired();
  }

  currentUser() {
    return JSON.parse(localStorage.getItem('profile'));
  }


  navigateToSignIn() {
    this.setRedirectUrl(this.router.url);
    this.router.navigate(['/signin']);
  }

  navigateToSignUp() {
    this.setRedirectUrl(this.router.url);
    this.router.navigate(['/signup']);
  }

  navigateToOAuthFacebook() {
    window.location.href = `${environment.APP_URL}/auth/facebook`;
  }

  navigateToOAuthGoogle() {
    window.location.href = `${environment.APP_URL}/auth/google_oauth2`;
  }

  setRedirectUrl(url: string) {
    if(!this.regexpSkipPathsToRedirectBack.test(url)) {
      localStorage.setItem('redirectUrl', url);
    }

  }

  redirectToBackOrDefault(defaultUrl = '') {
    if(localStorage.getItem('redirectUrl')) {
      this.router.navigateByUrl(localStorage.getItem('redirectUrl'));
      localStorage.removeItem('redirectUrl');
    } else {
      this.router.navigate([defaultUrl]);
    }
  }
}
