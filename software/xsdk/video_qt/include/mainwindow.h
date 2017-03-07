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
#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtGui>
#include <QCursor>
#include <qprocess.h>
#include <QDialog>
#include <QDesktopWidget>
#include <QWSServer>

#include <stdlib.h>
#include <getopt.h>

#include "video.h"
#include "ui_selector.h"


#define MAX_TEXT "Max"
#define MIN_TEXT "Min"
#define RELEASE_VERSION "2014.4"

#define CURSOR_INACTIVITY_TIME_MSEC 5000
#define ZYNQ_PIXMAP_INDEX 6
#define LAYER0_TRANSP_COLOR_EN 0
#define LAYER0_X_POS 0
#define LAYER0_Y_POS 0
#define LAYER0_TRANSPARENCY 0xff
#define TRANSPARENCY_FACTOR 3
#define SPLASH_720P_RECT_X  327
#define SPLASH_720P_RECT_Y  197

namespace Ui
{
class MainWindow;
}

/** Main application class where the ZYNQ HMI functionality is connected in a simple application*/
class MainWindow : public QMainWindow
{
    Q_OBJECT

public:

   explicit MainWindow(QWidget *parent = 0 ,bool apm_enable = true);
    ~MainWindow();

private slots:

    void on_enableVideo_clicked(bool checked);
    void on_tpgInterference_clicked(bool checked);
    void on_extVideo_clicked(bool checked);
    void on_sobelOff_clicked(bool checked);
    void on_sobelNoNeon_clicked(bool checked);
    void on_sobelHw_clicked(bool checked);
    void on_helpButton_pressed();
    void on_transparencySlider_valueChanged (int);
    void on_stateChangeApp_clicked();
    void CheckCursorActivity();


    //For sobel control functions.
    void on_chk_InvertSobel_clicked(bool checked);
    void on_hs_sobelthreshold_valueChanged(int);
private:
    Ui::ui_selector *ui;
    QCursor *cursor;
    QTimer *checkCursorTimer;
    QWSServer *qws;

    filter_mode filter_state;
    filter_func filter_fptr;
    video_src video_node;
    bool apm_enable;
    unsigned char activateScrSvCnt;
    QPoint cursorPos;
    int icounter;
    QVector<QString> pixmapVec;
    int isourceindex; //index holding the current selected source . ie
    //(Off- 0 ,software -1 ,hw -2 )
    int imodeindex; //index holding the current selected mode.
    //(external video - 0 ,tpginterference-3)

    bool isAppStateMaximized;
    int iWindowHeightInMinMode;   //window height in minimized mode.
    int iWindowHeightInMaxMode;  //Window height in maximized mode.
protected:
    void closeEvent(QCloseEvent* event);
    //Override mouse events to detect any mouse activity
    void mouseMoveEvent(QMouseEvent * event);
};

#endif // MAINWINDOW_H
