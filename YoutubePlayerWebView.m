//
//  YoutubePlayerWebView.m
//  study
//
//  Created by takeru on 2015/03/23.
//  Copyright (c) 2015年 rneuo. All rights reserved.
//

#import "YoutubePlayerWebView.h"

@implementation YoutubePlayerWebView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  self.allowsInlineMediaPlayback = YES;
  self.scrollView.bounces = NO;
  self.scrollView.scrollEnabled = NO;
  self.mediaPlaybackRequiresUserAction = NO;
  
  return self;
}

- (void)loadMovieWithVideoId:(NSString *)videoId {
  NSError *error = nil;
  self.videoId = videoId;

  NSDictionary *playerCallbacks = @{
                                    @"onReady" : @"onReady"
                                    // @"onYouTubeIframeAPIReady": @"onYouTubeIframeAPIReady",
                                    // @"onStateChange" : @"onStateChange",
                                    // @"onPlaybackQualityChange" : @"onPlaybackQualityChange",
                                    // @"onError" : @"onPlayerError"
                                    };
  
  self.playerParams = [[NSMutableDictionary alloc] init];
  self.playerParams[@"playerVars"] = @{
                                       @"playsinline": @(1),
                                       @"fs": @(0),
                                       @"rel": @(0),
                                       @"controls": @(1),
                                       @"loop": @(1),
                                       @"playlist": videoId,
                                       @"autoplay": @(1)
                                       };
  self.playerParams[@"height"]  = @"100%";
  self.playerParams[@"width"]   = @"100%";
  self.playerParams[@"events"]  = playerCallbacks;
  self.playerParams[@"videoId"] = videoId;
  

  
  self.playerParamsJSON = [NSJSONSerialization dataWithJSONObject:self.playerParams
                                                          options:NSJSONWritingPrettyPrinted
                                                            error:&error];

  NSString *playerVarsJsonString = [[NSString alloc] initWithData:self.playerParamsJSON
                                                         encoding:NSUTF8StringEncoding];
  
  NSString *path = [[NSBundle mainBundle] pathForResource:@"YoutubePlayerView-iframe-player"
                                                   ofType:@"html"
                                              inDirectory:@""];
  
  NSString *embedHTMLTemplate = [NSString stringWithContentsOfFile:path
                                                          encoding:NSUTF8StringEncoding
                                                             error:&error];
  
  NSString *embedHTML = [NSString stringWithFormat:embedHTMLTemplate, playerVarsJsonString];
  
  [self loadHTMLString:embedHTML
               baseURL:[NSURL URLWithString:@"about:blank"]];
}

- (void)playVideo {
  [self stringByEvaluatingJavaScriptFromString:@"player.playVideo();"];
}

- (void)pauseVideo {
  [self stringByEvaluatingJavaScriptFromString:@"player.pauseVideo();"];
}

- (void)stopVideo {
  [self stringByEvaluatingJavaScriptFromString:@"player.stopVideo();"];
}

- (float)currentTime {
  return [[self stringByEvaluatingJavaScriptFromString:@"player.getCurrentTime();"] floatValue];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  if ([request.URL.scheme isEqual:@"ytplayer"]) {
    return NO;
  }
  return YES;
}

@end
