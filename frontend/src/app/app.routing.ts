import { ModuleWithProviders} from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AuthGuard } from './auth/auth.guard';
import { ActiveOnSignOutGuard } from './auth/active-on-sign-out.guard';

import { QuestionsComponent } from './questions/questions.component';
import { QuestionFormComponent } from './questions/question-form/question-form.component';
import { QuestionDetailsComponent } from './questions/question-details/question-details.component';
import { AnswerEditComponent } from './questions/answers/answer-edit/answer-edit.component';
import { TagsComponent } from './tags/tags.component';
import { UsersComponent } from './users/users.component';
import { UserDetailsComponent } from './users/user-details/user-details.component';
import { SigninComponent } from './auth/signin/signin.component';
import { SignupComponent } from './auth/signup/signup.component';
import { ForgotPasswordComponent } from './auth/forgot-password/forgot-password.component';
import { EditPasswordComponent } from './auth/edit-password/edit-password.component';
import { OAuthCompleteComponent } from './auth/oauth-complete.component';

const APP_ROUTES: Routes = [
  { path: 'signin', component: SigninComponent, canActivate: [ActiveOnSignOutGuard] },
  { path: 'signup', component: SignupComponent, canActivate: [ActiveOnSignOutGuard] },
  { path: 'password/forgot', component: ForgotPasswordComponent, canActivate: [ActiveOnSignOutGuard] },
  { path: 'password/edit/:token', component: EditPasswordComponent, canActivate: [ActiveOnSignOutGuard] },
  { path: 'oauth-complete', component: OAuthCompleteComponent, canActivate: [ActiveOnSignOutGuard] },
  { path: 'users/:id/:slug', component: UserDetailsComponent },
  { path: 'users', component: UsersComponent },
  { path: 'tags', component: TagsComponent },

  { path: 'questions/new', component: QuestionFormComponent, canActivate: [AuthGuard] },
  { path: 'questions/search/:query', component: QuestionsComponent },
  { path: 'questions/tag/:tag', component: QuestionsComponent },
  { path: 'questions/:id/:slug', component: QuestionDetailsComponent },
  { path: 'questions/:id/:slug/edit', component: QuestionFormComponent, canActivate: [AuthGuard] },
  { path: 'questions/:quesiton_id/:question_slug/:answers/:id/edit', component: AnswerEditComponent, canActivate: [AuthGuard] },
  { path: '', component: QuestionsComponent }
];

export const routing = RouterModule.forRoot(APP_ROUTES);
