import { AdvicyPage } from './app.po';

describe('advicy App', function() {
  let page: AdvicyPage;

  beforeEach(() => {
    page = new AdvicyPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
