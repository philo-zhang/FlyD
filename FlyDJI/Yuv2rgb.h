//
//  Yuv2rgb.h
//  Butterfly
//
//  Created by zhangzhe on 6/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#ifndef Yuv2rgb_h
#define Yuv2rgb_h

#import <libavcodec/avcodec.h>
#import <libswscale/swscale.h>

@interface Yuv2rgb : NSObject

+ (bool)YV12ToBGR24_FFmpeg:(unsigned char*)pYUV rgb:(unsigned char*)pBGR24 hwidth:(int)width hheight:(int)height;

@end

#endif /* Yuv2rgb_h */
