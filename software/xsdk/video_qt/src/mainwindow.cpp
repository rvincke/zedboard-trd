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

#include <unistd.h>
#include <errno.h>

#include "mainwindow.h"
#include "perfmon.h"
#include "filter.h"

//Macros Definition
#define CURSOR_TIMER_INTERVAL 500


//Default GUI win.
#define APP_HEIGHT_1920_MAX 300
#define APP_HEIGHT_1280_MAX 200
#define APP_HEIGHT_1920_MIN  80
#define APP_HEIGHT_1280_MIN  65


MainWindow::MainWindow(QWidget *parent , bool state) :
QMainWindow(parent), apm_enable(state)
{
	int iret;
	int height = vlib_get_active_height();
	/* select main window user interface design depending on the screen resolution */
	if (height >= VRES_1080P)
	{
		ui = new Ui::ui_selector(Ui::ui_selector::UI_1080);
		/* Application Height in 1920x1280 mode */
		iWindowHeightInMinMode=APP_HEIGHT_1920_MIN;
		iWindowHeightInMaxMode=APP_HEIGHT_1920_MAX;

	}
	else
	{
		ui = new Ui::ui_selector(Ui::ui_selector::UI_720);
		iWindowHeightInMinMode=APP_HEIGHT_1280_MIN;
		iWindowHeightInMaxMode=APP_HEIGHT_1280_MAX;
		QApplication::setFont(QFont( QApplication::font().family(), 10));
	}


	/* Populate pixmap vector with the names of pixmap to attached GUI Label.
	 * using QT Resource file.
	 */
	pixmapVec.push_back(":/zynq/images/ExternalVideo_Sobel_off.png"); //Index 0
	pixmapVec.push_back(":/zynq/images/ExternalVideo_software_sobel.png");
	pixmapVec.push_back(":/zynq/images/ExternalVideo_Hardware_sobel.png");

	pixmapVec.push_back(":/zynq/images/TPG_Sobel_off.png");
	pixmapVec.push_back(":/zynq/images/TPG_software_sobel.png");
	pixmapVec.push_back(":/zynq/images/TPG_Hardware_sobel.png");
	pixmapVec.push_back(":/zynq/images/default.png");

	qws = QWSServer::instance();
	qws->setBackground(QBrush(QColor(0, 0, 0, 0)));

	/* Splash screen show the default Zynq image located in images directory */
	QSplashScreen splash(QPixmap(pixmapVec.at(ZYNQ_PIXMAP_INDEX)));
	QRect rect = splash.geometry();
	if (height != VRES_1080P){
		/* Changing CRTC resolution using DRM helper function will have
		no effect on emulated fbdev , so for 720p setting splash geometry
		programmatically */
		rect.moveTo(SPLASH_720P_RECT_X,SPLASH_720P_RECT_Y);
	}
	splash.setGeometry(rect);
	splash.show();
	sleep(3);

	ui->setupUi(this);
	QWidget::setWindowFlags(Qt::FramelessWindowHint);
	splash.finish(this);

	if (apm_enable) {
		/* Initialize perf-mon */
		iret = perf_monitor_init();
		if ( iret != EXIT_SUCCESS) {
		printf("TRD :: perfmon_init failed  \n");
		exit(EXIT_FAILURE);
		}
	} else {
		printf("TRD <info> :: Skip AXI Performance monitoring ! \n");
	}

	iret = vlib_query_pipeline_state();
	ASSERT(iret ,"TRD Application Exit !\n");

	vlib_drm_set_layer0_position (LAYER0_X_POS,height-this->height());
	/* set the cursor on top of window */
	cursor = new QCursor();
	cursor->setPos(0, 0);
	this->setCursor(*cursor);
	checkCursorTimer = new QTimer();


	/*Try to put cursor always on viewable area.*/
	connect(checkCursorTimer,SIGNAL(timeout()),this,SLOT(CheckCursorActivity()));
	checkCursorTimer->start(CURSOR_TIMER_INTERVAL);
	activateScrSvCnt = 0;

	/* Set the source and mode selection group boxes to disabled state till video is enabled */
	ui->grpBoxMode->setEnabled(false);
	ui->grpBoxSource->setEnabled(false);

	/* Enable mouse move tracking */
	setMouseTracking(true);
	centralWidget()->setMouseTracking(true);

	/* Set the default images on display panels */
	ui->imageDisplay2->setPixmap(QPixmap(pixmapVec.at(ZYNQ_PIXMAP_INDEX))); /* Load Xilinx logo as default*/
	ui->imageDisplay1->setPixmap(QPixmap(pixmapVec.at(ZYNQ_PIXMAP_INDEX))); /* Load Xilinx logo as default*/
	/* Default mode and source selected*/
	isourceindex=3;
	imodeindex=0;
	/* Set by default source - TPG interference,mode is Sobel-off */
	ui->rbtntpginterefernce->setChecked(true);
	ui->rbtnsobeloff->setChecked(true);
	/* By default app will be in maximized state   */
	isAppStateMaximized=true;
	/* Set the default values for Sobel sensitivity threshold */
    ui->lbl_sobelThreshold->setText(QString::number(HLS_SOBEL_HIGH_THRESH_VAL));
    /* Set the slider also to default Sobel sensitivity */
    ui->hs_sobelThreshold->setValue(HLS_SOBEL_HIGH_THRESH_VAL);
	/* Set the default status of Sobel invert filter */
	if(HLS_SOBEL_INVERT_VAL)
		ui->chkSobelInvert->setChecked(true);
	else
		ui->chkSobelInvert->setChecked(false);

	/* Set the Sobel control group box inactive */
	ui->grpBoxSobelControl->setEnabled(false);
	/* Set the TRD application release version */
	ui->lbl_releaseversion->setText(RELEASE_VERSION);
	filter_state = FILTER_MODE_OFF;
	filter_fptr = FILTER_FUNC_SOBEL;
	video_node = VIDEO_SRC_TPG;
}

MainWindow::~MainWindow()
{
	checkCursorTimer->stop();
	delete checkCursorTimer;
	delete cursor;
	delete ui;
}

/* Invoked when Enable video check-box is toggled. */
void MainWindow::on_enableVideo_clicked(bool checked)
{
	if(checked)	{
		/* TPG -> DRM */
		vlib_change_mode(video_node, filter_fptr, filter_state);
		filter_state = FILTER_MODE_OFF;
		ui->grpBoxMode->setEnabled(true);
		ui->grpBoxSource->setEnabled(true);
		ui->imageDisplay2->setPixmap(QPixmap(pixmapVec.at(isourceindex+imodeindex)));
	}
	else {
		vlib_pipeline_stop();
		filter_state = FILTER_MODE_OFF;
		video_node = VIDEO_SRC_TPG;
		/* Set the default values */
		ui->rbtnsobeloff->setChecked(true);
		ui->rbtntpginterefernce->setChecked(true);
		ui->grpBoxMode->setEnabled(false);
		ui->grpBoxSource->setEnabled(false);
		ui->grpBoxSobelControl->setEnabled(false);

		/* Set the default image on display Panel 2 */
		ui->imageDisplay2->setPixmap(QPixmap(pixmapVec.at(6)));
		isourceindex=3;
		imodeindex=0;
		qws->setBackground(QBrush(QColor(0, 0, 0, 0)));
	}
}


/* Invoked when test pattern generator is selected as
 * a input video source.
 */
void MainWindow::on_tpgInterference_clicked(bool checked)
{
	if(checked)	{
		if (video_node == VIDEO_SRC_TPG)
			return;
		video_node = VIDEO_SRC_TPG;
		vlib_change_mode(video_node, filter_fptr, filter_state);
		isourceindex=3;
		ui->imageDisplay2->setPixmap(QPixmap(pixmapVec.at(isourceindex+imodeindex)));

		if (filter_state == FILTER_MODE_SW) {
			opencv_sobel_invert(ui->chkSobelInvert->isChecked());
			opencv_sobel_thresh(ui->lbl_sobelThreshold->text().toInt(), HLS_SOBEL_LOW_THRESH_VAL);
		}

		if (filter_state == FILTER_MODE_HW) {
			v4l2_sobel_invert(ui->chkSobelInvert->isChecked());
			v4l2_sobel_thresh(ui->lbl_sobelThreshold->text().toInt(), HLS_SOBEL_LOW_THRESH_VAL);
		}
	}
}


/* Invoked if external video is selected as input video source */
void MainWindow::on_extVideo_clicked(bool checked)
{
	int ret =0;
	/* If external video is checked */
	if(checked)
	{
		if (video_node == VIDEO_SRC_HDMII)
			return;
		video_node = VIDEO_SRC_HDMII;
		ret = vlib_change_mode(video_node, filter_fptr, filter_state);
		if (ret  == VLIB_ERROR)
		{
			printf("Video Input Warning \n");
			QString msgBoxHeader="Video Input Warning";
			QString warncontent= "Video Input Not Proper! \n(set 1080p/720p depending on the mode used)\nReturning to previous TPG mode.";
			QMessageBox mb(
					msgBoxHeader,warncontent,QMessageBox::Warning,
					QMessageBox::Default,QMessageBox::Ok,
					QMessageBox::Escape );


			/* Sets the geometry of the MessageBox.*/

			/* Switch back to maximized mode in case of any errors.*/
			if(ui->btnAppState->text().compare(MIN_TEXT)!=0)
				on_stateChangeApp_clicked();

			int h = vlib_get_active_height();
			if(h >= VRES_1080P) /*1280*1080 resolution */
				mb.setGeometry(500,110,100,100);
			else
			{
				mb.setGeometry(220,75,100,100);
				mb.setFont(QFont("Arial",9));
			}

			/* Switching back to TPG Interference */
			ui->rbtntpginterefernce->setChecked(true);
			video_node = VIDEO_SRC_TPG;
			mb.exec();

		}
		else
		{
			isourceindex=0;
			ui->imageDisplay2->setPixmap(QPixmap(pixmapVec.at(isourceindex+imodeindex)));

			if (filter_state == FILTER_MODE_SW) {
				opencv_sobel_invert(ui->chkSobelInvert->isChecked());
				opencv_sobel_thresh(ui->lbl_sobelThreshold->text().toInt(), HLS_SOBEL_LOW_THRESH_VAL);
			}

			if (filter_state == FILTER_MODE_HW) {
				v4l2_sobel_invert(ui->chkSobelInvert->isChecked());
				v4l2_sobel_thresh(ui->lbl_sobelThreshold->text().toInt(), HLS_SOBEL_LOW_THRESH_VAL);
			}
		}
	}
}

/* Invoked if Sobel is off */
void MainWindow::on_sobelOff_clicked(bool checked)
{

	/* If Sobel off is checked */
	if(checked)
	{
		if (filter_state == FILTER_MODE_OFF)
			return;
		filter_state = FILTER_MODE_OFF;
		vlib_change_mode(video_node, filter_fptr, filter_state);
		imodeindex=0;
		ui->imageDisplay2->setPixmap(QPixmap(pixmapVec.at(isourceindex+imodeindex)));
		ui->grpBoxSobelControl->setEnabled(false);
	}
}


/* Invoked if user select to execute Sobel algorithm on ARM core */
void MainWindow::on_sobelNoNeon_clicked(bool checked)
{
	if(checked)	{
		if (filter_state == FILTER_MODE_SW)
			return;
		filter_state = FILTER_MODE_SW;
		vlib_change_mode(video_node, filter_fptr, filter_state);
		imodeindex=1;
		ui->imageDisplay2->setPixmap(QPixmap(pixmapVec.at(isourceindex+imodeindex)));
		ui->grpBoxSobelControl->setEnabled(true);

		opencv_sobel_invert(ui->chkSobelInvert->isChecked());
		opencv_sobel_thresh(ui->lbl_sobelThreshold->text().toInt(), HLS_SOBEL_LOW_THRESH_VAL);
	}
}


/*Invoked if user select to execute Sobel algorithm on FPGA */
void MainWindow::on_sobelHw_clicked(bool checked)
{
	/* If Sobel HW is selected */
	if(checked)	{
		if (filter_state == FILTER_MODE_HW)
			return;
		filter_state = FILTER_MODE_HW;
		vlib_change_mode(video_node, filter_fptr, filter_state);
		imodeindex=2;
		ui->imageDisplay2->setPixmap(QPixmap(pixmapVec.at(isourceindex+imodeindex)));
		ui->grpBoxSobelControl->setEnabled(true);

		v4l2_sobel_invert(ui->chkSobelInvert->isChecked());
		v4l2_sobel_thresh(ui->lbl_sobelThreshold->text().toInt(), HLS_SOBEL_LOW_THRESH_VAL);
	}
}

/*called when the timer expires every 500 msec */

void MainWindow::CheckCursorActivity()
{
	QPoint cursorCoords;
	/* Get central widget cursor position coordinates */
	cursorCoords = this->mapFromGlobal(QCursor::pos());

	/* Reset the cursor position if out of sync i.e if user try to move the
	 * mouse below the application display area , it just a hack to keep cursor always
	 * in a viewable area.
	 */
	if(isAppStateMaximized)
	{
		if(cursorCoords.y() >=iWindowHeightInMaxMode-10)
			cursor->setPos(cursorCoords.x(),iWindowHeightInMaxMode-10);
	}
	else
	{
		if(cursorCoords.y() >= iWindowHeightInMinMode-10)
		{
			cursor->setPos(cursorCoords.x(),iWindowHeightInMinMode-10);
		}
	}
	/*Update the current cursor position */
	this->setCursor(*cursor);
	cursorPos=cursorCoords;
}

/*Invokes when transparency slider is moved*/
void MainWindow::on_transparencySlider_valueChanged(int ival)
{

	int itransparencyVal=ival;
	ui->lbl_TransparencyVal->setText(QString::number(itransparencyVal));
	/* Add some correction to transparency value as end user may
	 * accidently make TRD GUI  fully transparent.
	 * Convert the GUI alpha range (0-50 ) to  range (0-100)
	 * As mapping to 255 will make it fully transparent.
	 */
	itransparencyVal=255-(ival*TRANSPARENCY_FACTOR);
	vlib_drm_set_layer0_transparency(itransparencyVal);
}

/*Invoked when MainWindow is minimized or maximized */
void MainWindow::on_stateChangeApp_clicked()
{

	int iscreenHeight=vlib_get_active_height();

	if((ui->btnAppState->text().compare(MIN_TEXT))==0)
	{
		/*If current app state is to be minimized */
		vlib_drm_set_layer0_position (LAYER0_X_POS,iscreenHeight-iWindowHeightInMinMode);
		/*Assuming X pixels is height of window in minimized mode*/
		ui->btnAppState->setText(MAX_TEXT);
		isAppStateMaximized=false;
	}
	/*currently application was maximized*/
	else
	{
		//Assuming X pixels is height of window in maximized mode.
		vlib_drm_set_layer0_position (LAYER0_X_POS,iscreenHeight-iWindowHeightInMaxMode);
		ui->btnAppState->setText(MIN_TEXT);
		isAppStateMaximized=true;
	}
}


/* Invoked when user press the help button */
void MainWindow::on_helpButton_pressed()
{

	/*Title of MessageBox */
	QString appname="Zynq Base Targeted Reference Design      ";
	/*Help content - To be updated with appropriate help message */
	QString helpcontent("Click on Enable Video  to start video on the screen   \n"
			"Experiment with different input video sources i.e (TPG or External).\n"
			"Change the mode of Sobel algorithm execution i.e (HW or SW )\n");
	QMessageBox mb(
			appname,helpcontent,QMessageBox::Information,
			QMessageBox::Default,
			QMessageBox::Ok,
			QMessageBox::Escape );

	/* Switch back to maximized mode for showing help message */
	if(ui->btnAppState->text().compare(MIN_TEXT)!=0)
		on_stateChangeApp_clicked();

	int h = vlib_get_active_height();
	if(h>=VRES_1080P) //1280*1080 resolution
		mb.setGeometry(1450,110,100,100);
	else
	{
		mb.setGeometry(910,75,100,100);
		mb.setFont(QFont("Arial",9));
	}
	mb.exec();


}


/* For handling window close event */
void MainWindow::closeEvent(QCloseEvent *event)
{

    /* Stop the video pipeline */
    vlib_pipeline_stop();
    vlib_drm_set_layer0_position (LAYER0_X_POS,LAYER0_Y_POS);
    vlib_drm_set_layer0_transparency(LAYER0_TRANSPARENCY);
    vlib_drm_uninit();
    vlib_uninit();
    if (apm_enable)
	perf_monitor_deinit();
    (void) event;
}


/* Invoked on every mouse move.Monitor cursor position , if cursor reaches near any non-viewable
 * area it is moved back to viewable area
 */
void MainWindow::mouseMoveEvent(__attribute__((unused))QMouseEvent *event)
{
	QPoint cursorCoords;
	/* Get central widget cursor position coordinates */
	cursorCoords = this->mapFromGlobal(QCursor::pos());
	/* Check if QT application is in maximized state */
	if(isAppStateMaximized)
	{
		/*If cursor position goes below the viewable area
		 * bring it back.
		 */
		if(cursorCoords.y() >=iWindowHeightInMaxMode-10)
			cursor->setPos(cursorCoords.x(),iWindowHeightInMaxMode-10);
	}
	else
	{
		/* If cursor position goes below the viewable area
		 * bring it back.
		 */
		if(cursorCoords.y() >= iWindowHeightInMinMode-10)
		{
			cursor->setPos(cursorCoords.x(),iWindowHeightInMinMode-10);
		}
	}
	/* Update the cursor position */
	this->setCursor(*cursor);
}

void MainWindow::on_chk_InvertSobel_clicked(bool checked)
{
	/* Check current Sobel mode*/
	if(ui->rbtnsobelSw->isChecked())
		opencv_sobel_invert(checked);

	if(ui->rbtnsobelHw->isChecked())
		v4l2_sobel_invert(checked);
}

void MainWindow::on_hs_sobelthreshold_valueChanged(int val)
{
    //Check current sobel mode.
	if(ui->rbtnsobelSw->isChecked())
		opencv_sobel_thresh(val, HLS_SOBEL_LOW_THRESH_VAL);

	if(ui->rbtnsobelHw->isChecked())
		v4l2_sobel_thresh(val, HLS_SOBEL_LOW_THRESH_VAL);

	ui->lbl_sobelThreshold->setText(QString::number(val));
}
