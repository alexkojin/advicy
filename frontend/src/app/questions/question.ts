import { Answer } from './answers/answer';

export class Question {
  id: number;
  title: string;
  slug: string;
  description: string;
  description_html: string;
  category_slug: string;
  answers: Answer[];
  tag_list: Array<String>
}
