# 使用方法

## header

```
#import "YoutubePlayerWebView.h"
@interface HogeViewController : UIViewController<YoutubePlayerWebViewDelegate>
・・・
@end
```

## Implement

```
@interface HogeViewController ()
  @property (strong, nonatomic) YoutubePlayerWebView *player;
@end
```

```
- (IBAction)controlAction:(id)sender {
  [self.player playVideo];
}
```

```
- (void)viewDidLoad {
  [super viewDidLoad];
  self.player = [[YoutubePlayerWebView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 220)];
  self.player.delegate = self;
  [self.player loadMovieWithVideoId:self.detailItem[@"videoId"]];
  [self.view addSubview:self.player];
}
```
