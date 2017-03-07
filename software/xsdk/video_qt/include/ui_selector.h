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
#ifndef UI_SELECTOR_H
#define UI_SELECTOR_H

#include "ui_mainwindow.h"
#include "ui_mainwindow720.h"

QT_BEGIN_NAMESPACE
namespace Ui {

class ui_selector
{
public:

    QPushButton *btnAppState; //added by radheys
    QLabel *lbl_TransparencyVal;

    QGroupBox *grpBoxSource;
    QGroupBox *grpBoxMode;

    QLabel *imageDisplay1;
    QLabel *imageDisplay2;


    QRadioButton *rbtntpginterefernce;
    QRadioButton *rbtnsobeloff;
    QRadioButton *rbtnsobelSw;
    QRadioButton *rbtnsobelHw;

    QPushButton *helpbutton;


    //For Sobel Controls

    QCheckBox  *chkSobelInvert;
    QGroupBox *grpBoxSobelControl;

    QLabel *lbl_sobelThreshold;

    QSlider *hs_sobelThreshold;

    QLabel *lbl_releaseversion;

    enum UI_typeE {
        UI_1080,
        UI_720
    };

    ui_selector(enum UI_typeE uiType)
    {
        type = uiType;
    }

    void setupUi(QMainWindow *window)
    {
        switch(type)
        {
        case UI_1080:
            ui1.setupUi(window);
            //Added for accessing and changing application state. -radheys
            btnAppState=ui1.stateChangeApp;
            lbl_TransparencyVal=ui1.lbl_inputTransparency;
            ui1.cpu->cpu1Lable = ui1.lbl_cpu1UsageVal;
            ui1.cpu->cpu2Lable = ui1.lbl_cpu2UsageVal;
            ui1.memory->hpPort0=ui1.lbl_HPPort0UsageVal;
            ui1.memory->hpPort2=ui1.lbl_HPPort2UsageVal;

            grpBoxSource=ui1.groupBox_source;
            grpBoxMode=ui1.groupBox_mode;
            imageDisplay1=ui1.lbl_imageDisplay1;
            imageDisplay2=ui1.lbl_imageDisplay2;

            rbtntpginterefernce=ui1.tpgInterference;
            rbtnsobeloff=ui1.sobelOff;
            rbtnsobelSw=ui1.sobelNoNeon;
            rbtnsobelHw=ui1.sobelHw;

            helpbutton=ui1.helpButton;

            //Added for sobel control

            // Invert for sobel filter
            chkSobelInvert=ui1.chk_InvertSobel;

            //Sobel Threshold .
            lbl_sobelThreshold=ui1.lbl_sobelThreshold;
            //For sobel control group box.(Disabling the
            //group box when sobel mode is off)
            grpBoxSobelControl=ui1.groupBox_sobelControl;

            //For setting sobel default threshold.
            hs_sobelThreshold=ui1.hs_sobelthreshold;

            //For Displaying release version
            lbl_releaseversion=ui1.lbl_releaseversion;

            break;
        case UI_720:
            ui2.setupUi(window);
            //Added for accessing and changing application state. -radheys
            btnAppState=ui2.stateChangeApp;
            lbl_TransparencyVal=ui2.lbl_inputTransparency;

            ui2.cpu->cpu1Lable = ui2.lbl_cpu1UsageVal;
            ui2.cpu->cpu2Lable = ui2.lbl_cpu2UsageVal;
            ui2.memory->hpPort0=ui2.lbl_HPPort0UsageVal;
            ui2.memory->hpPort2=ui2.lbl_HPPort2UsageVal;

            grpBoxSource=ui2.groupBox_source;
            grpBoxMode=ui2.groupBox_mode;
            imageDisplay1=ui2.lbl_imageDisplay1;
            imageDisplay2=ui2.lbl_imageDisplay2;

            rbtntpginterefernce=ui2.tpgInterference;
            rbtnsobeloff=ui2.sobelOff;
            rbtnsobelSw=ui2.sobelNoNeon;
            rbtnsobelHw=ui2.sobelHw;
            helpbutton=ui2.helpButton;


            //Added for sobel control

            // Invert for sobel filter
            chkSobelInvert=ui2.chk_InvertSobel;

            //Sobel Threshold .
            lbl_sobelThreshold=ui2.lbl_sobelThreshold;

            //For sobel control group box.(Disabling the
            //group box when sobel mode is off)
            grpBoxSobelControl=ui2.groupBox_sobelControl;

            //For setting sobel default threshold.
            hs_sobelThreshold=ui2.hs_sobelthreshold;

            //For Displaying release version
            lbl_releaseversion=ui2.lbl_releaseversion;
            break;
        }
    }

    void retranslateUi(QMainWindow *window)
    {
        switch(type)
        {
        case UI_1080:
            ui1.retranslateUi(window);
            break;
        case UI_720:
            ui2.retranslateUi(window);
            break;
        }
    }



private:
    Ui::MainWindow ui1;
    Ui::MainWindow720 ui2;
    enum UI_typeE type;

};


} // namespace Ui

QT_END_NAMESPACE

#endif // UI_SELECTOR_H
