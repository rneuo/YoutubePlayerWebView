//
//  YoutubePlayerWebView.h
//  study
//
//  Created by takeru on 2015/03/23.
//  Copyright (c) 2015年 rneuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YoutubePlayerWebView;

@protocol YoutubePlayerWebViewDelegate <UIWebViewDelegate>

@required

@optional

@end

@interface YoutubePlayerWebView : UIWebView<NSObject>

#pragma mark - instance variables

@property (strong, nonatomic) NSMutableDictionary *playerParams;
@property (strong, nonatomic) NSData *playerParamsJSON;
@property (strong, nonatomic) NSString *videoId;
@property (nonatomic, assign) id<YoutubePlayerWebViewDelegate> delegate;

#pragma mark - public method

- (void)playVideo;
- (void)pauseVideo;
- (void)stopVideo;
- (float)currentTime;
- (id)initWithFrame:(CGRect)frame;
- (void)loadMovieWithVideoId:(NSString *)videoId;

@end
