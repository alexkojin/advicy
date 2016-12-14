export class Question {
  id: number;
  title: string;
  slug: string;
  description: string;
  description_html: string;
  category_slug: string;
  answers: any;
  tag_list: Array<String>
}
