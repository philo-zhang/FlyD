//
//  Yuv2rgb.m
//  Butterfly
//
//  Created by zhangzhe on 6/9/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Yuv2rgb.h"

@implementation Yuv2rgb

+ (bool)YV12ToBGR24_FFmpeg:(unsigned char*) pYUV rgb:(unsigned char*) pBGR24 hwidth:(int) width hheight:(int) height {
    if (width < 1 || height < 1 || pYUV == NULL || pBGR24 == NULL)
        return false;
    //int srcNumBytes,dstNumBytes;
    //uint8_t *pSrc,*pDst;
    AVPicture pFrameYUV,pFrameBGR;
    
    //pFrameYUV = avpicture_alloc();
    //srcNumBytes = avpicture_get_size(PIX_FMT_YUV420P,width,height);
    //pSrc = (uint8_t *)malloc(sizeof(uint8_t) * srcNumBytes);
    avpicture_fill(&pFrameYUV,pYUV,AV_PIX_FMT_YUV420P,width,height);
    
    //U,V互换
    uint8_t * ptmp=pFrameYUV.data[1];
    pFrameYUV.data[1]=pFrameYUV.data[2];
    pFrameYUV.data[2]=ptmp;
    
    //pFrameBGR = avcodec_alloc_frame();
    //dstNumBytes = avpicture_get_size(PIX_FMT_BGR24,width,height);
    //pDst = (uint8_t *)malloc(sizeof(uint8_t) * dstNumBytes);
    avpicture_fill(&pFrameBGR,pBGR24,AV_PIX_FMT_BGR32_1,width,height);
    
    struct SwsContext* imgCtx = NULL;
    imgCtx = sws_getContext(width,height,AV_PIX_FMT_YUV420P,width,height,AV_PIX_FMT_BGR32_1,SWS_BILINEAR,0,0,0);
    
    if (imgCtx != NULL){
        sws_scale(imgCtx,pFrameYUV.data,pFrameYUV.linesize,0,height,pFrameBGR.data,pFrameBGR.linesize);
        if(imgCtx){
            sws_freeContext(imgCtx);
            imgCtx = NULL;
        }
        return true;
    }
    else{
        sws_freeContext(imgCtx);
        imgCtx = NULL;
        return false;
    }
}


@end
