/*
   (c) Copyright 2012  Xylon d.o.o.

   This file is subject to the terms and conditions of the MIT License:

   Permission is hereby granted, free of charge, to any person
   obtaining a copy of this software and associated documentation
   files (the "Software"), to deal in the Software without restriction,
   including without limitation the rights to use, copy, modify, merge,
   publish, distribute, sublicense, and/or sell copies of the Software,
   and to permit persons to whom the Software is furnished to do so,
   subject to the following conditions:

   The above copyright notice and this permission notice shall be
   included in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <stdio.h>
#include <getopt.h>
#include <errno.h>
#include <stdlib.h>

#include "mainwindow.h"
#include "video.h"

static void usage(const char *argv0)
{
	printf("Usage: %s [options]\n", argv0);
	printf("-d, --drm-module name  DRM module: 'xilinx' or 'xylon' (default: xylon)\n");
	printf("-h, --help             Show this help screen\n");
	printf("-r, --resolution WxH   Width'x'Height (default: 1920x1080)\n");
	printf("--no-apm               Disable AXI Performance monitor (APM)\n");
}

static struct option opts[] = {
	{ "drm-module", required_argument, NULL, 'd' },
	{ "help", no_argument, NULL, 'h'},
	{ "resolution", required_argument, NULL, 'r' },
	{ "no-apm" ,no_argument, NULL , 'n'},
	{ NULL, 0, NULL, 0 }
};


int main(int argc, char *argv[])
{
	int ret = 0;

	/* Options parsing */
	int c;
	int hdmi_out_width = HRES_1080P;
	int hdmi_out_height = VRES_1080P;
	drm_module module = DRM_MODULE_XYLON;
	bool apm_enable = true;

	/* Parse command line arguments */
	while ((c = getopt_long(argc, argv, "d:hr:", opts, NULL)) != -1) {
		switch (c) {
		case 'd':
			module = static_cast <drm_module> (vlib_drm_get_module_type(optarg));
			if (module == DRM_MODULE_NONE) {
				printf("Invalid DRM module '%s'\n", optarg);
				return 1;
			}
			break;
		case 'h':
			usage(argv[0]);
			return 0;
		case 'r':
			ret = sscanf(optarg, "%ux%u", &hdmi_out_width, &hdmi_out_height);
			if (ret != 2) {
				printf("Invalid size '%s'\n", optarg);
				return 1;
			}
			break;
		case 'n':
			apm_enable = false;
			break;
		default:
			printf("Invalid option -%c\n", c);
			printf("Run %s -h for help\n", argv[0]);
			return 1;
		}
	}

	/* Validation for HDMI height /width  as QT currently support only 1080/720p */
	if (!(((hdmi_out_width == HRES_1080P) && (hdmi_out_height == VRES_1080P)) ||
		  ((hdmi_out_width == HRES_720P)  && (hdmi_out_height == VRES_720P)))) {
		printf("[video_qt] TRD QT application currently supports only 1080p and 720p modes\n");
		printf("[video_qt] Application Exit !!!! \n");
		abort();
	}

	/* Initialize video library */
	vlib_init();
	vlib_set_drm_module(module);
	vlib_set_active_height(hdmi_out_height);
	vlib_set_active_width(hdmi_out_width);
	vlib_drm_init();

	/* Enabling QWS Server */
	QApplication a(argc, argv, QApplication::GuiServer);
	MainWindow w(NULL,apm_enable);
	w.show();
	ret = a.exec();

	return ret;
}
