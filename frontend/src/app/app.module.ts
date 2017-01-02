import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule, Http, RequestOptions } from '@angular/http';
import { RouterModule } from '@angular/router';

import { Ng2PaginationModule } from 'ng2-pagination';
import { AuthHttp, AuthConfig } from 'angular2-jwt';

import { AppComponent } from './app.component';

import { routing } from './app.routing';

import { AuthGuard } from './auth/auth.guard';
import { ActiveOnSignOutGuard } from './auth/active-on-sign-out.guard';

import { AuthService } from './auth/auth.service';
import { UserService } from './users/user.service';
import { QuestionService} from './questions/question.service';
import { AnswerService } from './questions/answers/answer.service';
import { VoteService } from './questions/vote-control/vote.service';
import { ShareService } from './shared/share-modal/share.service';
import { ViewService } from './shared/view.service';
import { FlagService } from './shared/flag/flag.service';

import { SearchComponent } from './search/search.component';

import { QuestionsComponent } from './questions/questions.component';
import { QuestionListComponent } from './questions/question-list/question-list.component';
import { QuestionItemComponent } from './questions/question-list/question-item.component';
import { QuestionDetailsComponent } from './questions/question-details/question-details.component';
import { JobsComponent } from './jobs/jobs.component';
import { TagsComponent } from './tags/tags.component';
import { UsersComponent } from './users/users.component';
import { UserDetailsComponent } from './users/user-details/user-details.component';
import { SigninComponent } from './auth/signin/signin.component';
import { SignupComponent } from './auth/signup/signup.component';
import { QuestionFormComponent } from './questions/question-form/question-form.component';
import { RelatedQuestionsComponent } from './questions/related-questions/related-questions.component';
import { AnswersComponent } from './questions/answers/answers.component';
import { VoteControlComponent } from './questions/vote-control/vote-control.component';
import { MdEditorComponent } from './md-editor/md-editor.component';
import { AnswerItemComponent } from './questions/answers/answer-item.component';
import { CommentsComponent } from './questions/comments/comments.component';
import { AuthModalComponent } from './auth/auth-modal/auth-modal.component';
import { AnswerEditComponent } from './questions/answers/answer-edit/answer-edit.component';
import { ShareModalComponent } from './shared/share-modal/share-modal.component';
import { ShareButtonComponent } from './shared/share-button/share-button.component';
import { FlagButtonComponent } from './shared/flag/flag-button.component';
import { FlagModalComponent } from './shared/flag/flag-modal.component';
import { OAuthCompleteComponent } from './auth/oauth-complete.component';
import { ForgotPasswordComponent } from './auth/forgot-password/forgot-password.component';
import { EditPasswordComponent } from './auth/edit-password/edit-password.component';
import { CommentItemComponent } from './questions/comments/comment-item.component';
import { CommentFormComponent } from './questions/comments/comment-form.component';
import { ActionMenuComponent } from './shared/action-menu/action-menu.component';

export function authFactory(http: Http, options: RequestOptions) {
  return new AuthHttp(new AuthConfig({
    globalHeaders: [{'Content-Type':'application/json', 'Accept':'application/json'}],
    noJwtError: true
  }), http, options);
};

export const authProvider = {
  provide: AuthHttp,
  deps: [Http, RequestOptions],
  useFactory: authFactory
};

@NgModule({
  declarations: [
    AppComponent,
    QuestionsComponent,
    QuestionListComponent,
    QuestionItemComponent,
    QuestionDetailsComponent,
    SearchComponent,
    JobsComponent,
    TagsComponent,
    UsersComponent,
    UserDetailsComponent,
    SigninComponent,
    SignupComponent,
    QuestionFormComponent,
    RelatedQuestionsComponent,
    AnswersComponent,
    VoteControlComponent,
    MdEditorComponent,
    AnswerItemComponent,
    CommentsComponent,
    AuthModalComponent,
    AnswerEditComponent,
    ShareModalComponent,
    ShareButtonComponent,
    FlagButtonComponent,
    FlagModalComponent,
    OAuthCompleteComponent,
    ForgotPasswordComponent,
    EditPasswordComponent,
    CommentItemComponent,
    CommentFormComponent,
    ActionMenuComponent
  ],
  imports: [
    BrowserModule,
    routing,
    FormsModule,
    HttpModule,
    Ng2PaginationModule
  ],
  providers: [
    AuthGuard,
    ActiveOnSignOutGuard,
    AuthService,
    UserService,
    QuestionService,
    AnswerService,
    VoteService,
    ShareService,
    ViewService,
    FlagService,
    authProvider
    ],
  bootstrap: [AppComponent]
})
export class AppModule { }
