/*
 * img_process.c
 *
 *  Created on: Sep 18, 2014
 *      Author: ckohn
 */

#include "opencv2/opencv.hpp"
#include "filter.h"

extern void opencv_sobel(IplImage *src, IplImage *dst);

void opencv_func(unsigned char *frm_data_in, unsigned char *frm_data_out,
				 int height, int width, int stride, filter_func func)
{
   	// constructing OpenCV interface
	IplImage* src_dma = cvCreateImageHeader(cvSize(width, height), IPL_DEPTH_8U, 2);
	IplImage* dst_dma = cvCreateImageHeader(cvSize(width, height), IPL_DEPTH_8U, 2);
	src_dma->imageData = (char *) frm_data_in;
	dst_dma->imageData = (char *) frm_data_out;
	src_dma->widthStep = 2 * stride;
	dst_dma->widthStep = 2 * stride;

	// call processing function
	switch (func) {
	case FILTER_FUNC_SOBEL:
		opencv_sobel(src_dma, dst_dma);
		break;
	}

	cvReleaseImageHeader(&src_dma);
	cvReleaseImageHeader(&dst_dma);
}
