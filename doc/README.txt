*************************************************************************
   ____  ____
  /   /\/   /
 /___/  \  /
 \   \   \/    © Copyright 2014 Xilinx, Inc. All rights reserved.
  \   \        This file contains confidential and proprietary
  /   /        information of Xilinx, Inc. and is protected under U.S.
 /___/   /\    and international copyright and other intellectual
 \   \  /  \   property laws.
  \___\/\___\

*************************************************************************

Vendor: Xylon d.o.o.
Current README.txt Version: 2.11.0
Date Last Modified        : 23MAR2015
Date Created              : 31MAY2012

Associated Filename: logiREF-BTRD-2014.4-ZED_150324.jar
Associated Document: http://www.logicbricks.com/logicBRICKS/Reference-logicBRICKS-Design/Ported-Xilinx-TRD-to-ZedBoard.aspx
		     US873 - Zynq Concepts, Tools and Techniques
		     UG798 - Xilinx Design Tools: Installation and Licensing Guide
ZedBoard info: http://zedboard.org/support/documentation/1521
Supported Device(s): XC7Z020-1CLG484

XYLON DISTRIBUTES THIS DESIGN WITH PERMISSION FROM XILINX, INC.

*************************************************************************

Disclaimer:

      This disclaimer is not a license and does not grant any rights to
      the materials distributed herewith. Except as otherwise provided in
      a valid license issued to you by Xilinx, and to the maximum extent
      permitted by applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE
      "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL
      WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
      INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY,
      NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
      (2) Xilinx shall not be liable (whether in contract or tort,
      including negligence, or under any other theory of liability) for
      any loss or damage of any kind or nature related to, arising under
      or in connection with these materials, including for any direct, or
      any indirect, special, incidental, or consequential loss or damage
      (including loss of data, profits, goodwill, or any type of loss or
      damage suffered as a result of any action brought by a third party)
      even if such damage or loss was reasonably foreseeable or Xilinx
      had been advised of the possibility of the same.

Critical Applications:

      Xilinx products are not designed or intended to be fail-safe, or
      for use in any application requiring fail-safe performance, such as
      life-support or safety devices or systems, Class III medical
      devices, nuclear facilities, applications related to the deployment
      of airbags, or any other applications that could lead to death,
      personal injury, or severe property or environmental damage
      (individually and collectively, "Critical Applications"). Customer
      assumes the sole risk and liability of any use of Xilinx products
      in Critical Applications, subject only to applicable laws and
      regulations governing limitations on product liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS
FILE AT ALL TIMES.

*************************************************************************

The video_qt application shipped with this reference design is based in
part on the work of the Qwt project (http://qwt.sf.net).

*************************************************************************

The applications shipped with this reference design include Linux kernel
header files and are not considered a "derivative work" for the purposes
of the GPL.

*************************************************************************

The Zynq Base TRD ZED package is a port of the Xilinx Zynq Base TRD package
(http://www.wiki.xilinx.com/Zynq+Base+TRD+2014.4) to the ZedBoard (http://zedboard.org).
This document is based on the Xilinx TRD README.txt file.

XYLON DISTRIBUTES THIS DESIGN WITH PERMISSION FROM XILINX, INC.

*************************************************************************

This readme file contains these sections:

1. REVISION HISTORY
2. OVERVIEW
3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS
4. DESIGN FILE HIERARCHY
5. INSTALLATION AND OPERATING INSTRUCTIONS
6. OTHER INFORMATION
7. SUPPORT

1. REVISION HISTORY


            Readme
Date        Version      Revision Description
=========================================================================
31MAY2012   2.1.0       Zynq Base TRD 14.1 (2012.1) -- Initial Release
27JUL2012   2.2.0       Zynq Base TRD 14.2 (2012.2)
                            ~ IPs and Software Application upgraded for
                              14.2 (2012.2) tool version
                            ~ Drivers rebased for linux kernel 3.3
                            ~ Added kernel base driver for sobel filter
                            ~ Added support for 720p (along with 1080p)
                              depending on devicetree config.
                            ~ Software fixes
04OCT2012   2.2.1       Zynq Base TRD 14.2 (2012.2) Update 1
                            ~ FSBL modifications to fix issue when connecting
                            external video source through FMC IMAGEON
                            daughter card
19OCT2012   2.3.0       Zynq Base TRD 14.3 (2012.3)
                            ~ IPs and Software Application upgraded for
                              14.3 (2012.3) tool version
                            ~ Drivers rebased for Linux kernel 3.5
                            ~ UI Layout changed to horizontal orientation.
                              UI can be semi-transparent and pictorial
                              representation of sobel mode is Available.
17DEC2012  2.4.0       Zynq Base TRD 14.4 (2012.4)
                            ~ IPs and Software Application upgraded for
                              14.4(2012.4) tool version.
                            ~ Switch to TPG using AXI4-Stream.
                            ~ One Perf monitor for monitoring AXI bandwidth.
                            ~ Drivers rebased for Linux kernel 3.6
                            ~ new VDMA linux driver.
                            ~ Autotransparency in Sobel QT removed.
                            ~ Minor UI Fix.
18APR2013  2.5.0      Zynq Base TRD 14.5 (2013.1)
                            ~ IPs and Software Application upgraded for
                              14.5(2013.1) tool version.
                            ~ Integrated with linux Framebuffer API.
                            ~ UIO Linux drivers for Xilinx Video IPs.
                            ~ Configurable sobel controls i.e inversion of sobel
                              mode and changing sobel sensitivity .
                            ~ FMC detection based on reading IPMI FRU.
                            ~ One common API (sobel_lib)for both cmd and QT
                              applications.
                            ~ Video detection feature of Xilinx VTC IP used for
                              checking resolution of external video.
                            ~ QT resource file
03JULY2013 2.6.0       Zynq Base TRD 2013.2
                            ~ System hardware implementation in Vivado
                            ~ PetaLinux Framework
                            ~ Video Frame Synchronization using GenLock with TPG VDMA,
                              FILTER VDMA and LogiCVC.
10DEC2013 2.7.0        Zynq Base TRD 2013.3
                            ~ IPs and Software upgraded for 2013.3 tool
                              version.
                            ~ Petalinux SDK 2013.10
                            ~ Auto-start script decoupled from FIT image(image.ub).
                              User can easily customize auto-start of sobel QT application.
                            ~ Improved TRD boot up time.
20JAN2014 2.8.0        Zynq Base TRD 2013.4
                            ~ IPs and Software upgraded for 2013.4 tool
                              version.

30JUL2014 2.9.0        Zynq Base TRD 2014.2
                            ~ IPs and Software upgraded for 2014.2 tool
                              version.
			    ~ Petalinux 2014.2
			    ~ Implements Linux V4L2 , media
			      framework for video capture/control and direct
			      rendering manager(DRM) framework for video
                              display.
                            ~ Input video pipe is converted to YUV422 format
15DEC2014 2.10.0        Zynq Base TRD 2014.4
                            ~ IPs and Software upgraded for 2014.4 tool
                              version.
			    ~ Petalinux 2014.4
			    ~ DRM: Implements universal plane support.
			    ~ APM in profile mode.
			    ~ Sobel software code uses OpenCV.
			    ~ Sobel HLS core switched to adapter-less flow.
			    ~ SD card image changed from FIT to discrete
			      components.

18MAR2015 2.11.0        ZedBoard Zynq Base TRD 2014.4
                            ~ Initial Vivado 2014.4 release for ZedBoard
=========================================================================



2. OVERVIEW

The Base TRD is an embedded video processing application designed to showcase
various features and capabilities of Zynq Z-7020 All Programmable SoC (AP SoC)
device for the embedded domain. The Base TRD consists of two elements: The
Zynq-7000 AP SoC Processing System (PS) and a video processing pipeline
implemented in Programmable Logic (PL). The AP SoC allows the user to implement
a video processing algorithm that performs edge detection on an image (Sobel
filter) either as a software program running on the Zynq-7000 AP SoC PS or as
a hardware accelerator inside the PL.

The Base TRD demonstrates how the user can seamlessly switch between a software
or a hardware implementation and evaluate the cost and benefit of each
implementation. The TRD also demonstrates the value of offloading computation
intensive tasks onto PL, thereby freeing the CPU resources to be available for
user-specific applications.

The package consists of two video based application projects which differ
in user interface.
a) video_qt application has a graphical user interface designed
using QT framework.
b) video_cmd application has a command line based menu where the user can
navigate the menu by typing options into the terminal.

This package is based on the Xilinx Zynq TRD and all the Xilinx instructions
apply except for the u-boot,Linux kernel, device-tree and applications build that contain some diferences.
For information on how to use this package, along with build instructions,
please refer:
 - http://www.wiki.xilinx.com/Zynq+Base+TRD+2014.4
 - Chapter 5. Building Design

3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS

Software:
  -- Vivado Design Suite 2014.4
  -- Proper installation of required license files for the TRD.
  -- Optional: ZedBoard board uses CP210x USB to UART Bridge to provide COM port
     connection to the board. This configuration is highly recommended because
     the UART outputs information to hyper terminal right after power up.
     To use this feature, hyper terminal, Minicom, teraterm or equivalent
     terminal software on the host machine is required. For details, please
     refer to UG925 for USB-to-UART Bridge driver installation.
  -- For additional information on software installation, refer to UG798.

Hardware:
  -- The reference design targets the Zynq ZedBoard evaluation board, Rev C or
     above.
  -- ZedBoard evaluation board setup in the default configuration as documented
     in the Default Switch and Jumper Setting:
     http://zedboard.org/sites/default/files/documentations/GS-AES-Z7EV-7Z020-G-V7.pdf
  -- AC power adapter (12VDC)
  -- HDMI-to-HDMI or HDMI-to-DVI cable (depending on available Monitor)
  -- Monitor capable of supporting 1080p60 / 720p60
  -- USB Type-A Female to USB Micro-B Male cable
  -- USB hub
  -- USB mouse
  -- Optional: USB Type A Male to USB Mini-B Male cable if using USB-to-UART
     bridge
  -- Optional: Avnet FMC IMAGEON daughter card for video input with 1080p / 720p
     input video source
  -- SD memory card reader for transferring files onto the SD card.
     (not included in the package)


4. DESIGN FILE HIERARCHY


The directory structure underneath this top-level folder is described
below:

\Source
 |
 +----- \doc
 |
 |           +--\lgpl-2.1.txt
 |                 Copy of LGPL LICENSE
 |
 |           +--\README.txt
 |              This file
 |
 +----- \hardware
 |           +--\avnet_ip
 |              IP core from Avnet Electronics Marketing - source and interfaces
 |
 |           +--\logicbricks
 |              IP cores from Xylon d.o.o (logicBRICKS) - sources and interfaces
 |
 |           +--\xilinx.com
 |              IP cores from Xilinx Inc. - sources and interfaces
 |
 |----- \vivado_btrd
 |           +--\data
 |              Top-level design constraints
 |
 |           +--\fpga
 |              Design bitstream file
 |
 |           +--\scripts
 |              Scripts used for building the design project in Vivado 2014.4
 |
 |           +--\srcs
 |              +--\hdl
 |                 Design's top-level wrapper HDL (.vhd)
 |
 |              +--\ui
 |                 Block design customized GUI (.ui)
 |
 |           +--\create_project.html
 |              Instructions on how to build a project 
 |              from the provided scripts in scripts diredtory
 |
 |----- \vivado_hls
 |              Vivado HLS project .The C-algorithm for the sobel
 |              filter that gets synthesized to an RTL pcore
 |
 +----- \ready_to_test
 |
 |           +--\BOOT.BIN
 |              Zynq Boot Image, which is created from
 |              FSBL, hardware bitstream and u-boot
 |
 |           +--\uImage
 |              Xilinx Linux kernel
 |
 |           +--\devicetree.dtb
 |              Device tree with TPG support
 |
 |           +--\devicetree_fmc.dtb
 |              Device tree with TPG and external video support
 |
 |           +--\uramdisk.image.gz
 |              ramdisk image with third party libs/apps(DRM,V4Ls)
 |
 |           +--\autostart.sh
 |              TRD init script
 |
 |           +--\bin
 |              Contains video cmd and QT applications
 |
 +----- \software
 |
 |           +--\makeBin
 |              Design bitstream,
 |              FSBL executable/linkable file
 |              u-boot executable/linkable file
 |
 |           +--\patches
 |              Kernel patch that adds logiCLK driver
 |
 |           +--\xsdk
 |              TRD application/libraries for XSDK
 |
 |           +--\petalinux
 |              Petalinux project
 |              Includes-
 |              Kernel,u-boot configurations
 |              User application and libraries
 |
 |           +--\pre-built.tar.gz
 |              Header files and dynamic libraries of DRM/KMS
 |              and other multimedia frameworks and
 |              Xilinx Linux 3.17 header files
 |              Note:These files must be “unzipped” before they can be used
 |
 |           +--\README_pre-built.txt
 |              Extracting files warning
 |

5. INSTALLATION AND OPERATING INSTRUCTIONS


ZedBoard Initial Setup:
--------------------

-- All jumpers and switches should be in default setting except JP7 to JP11.
   Jumpers JP7 to JP11 should be set to boot from SD card.
   See image for SD boot in 
   http://zedboard.org/sites/default/files/documentations/GS-AES-Z7EV-7Z020-G-V7.pdf (Figure 2):
   JP7  : GND
   JP8  : GND
   JP9  : VCC
   JP10 : VCC
   JP11 : GND
-- Connect one end of the HDMI cable to board HDMI connector, connect the other
   end to the monitor's HDMI or DVI input
-- Connect USB Micro-AB cable to on-board USB Micro connector USB OTG (connector J13), then connect up
   USB hub, mouse and keyboard.
-- connect the AC power adapter
-- Optional: If USB-to-UART bridge is used, connect USB Micro-AB side of USB-to-
   Micro-AB cable to the on-board mini USB connector UART (connector J14). Connect USB side to
   the control PC.
-- Optional: If Avnet Imageon card is used, connect the card to FMC slot (connector J1).
   Connect 1080p/720p video input source to HDMI-IN.

   
FPGA design differences between the Xilinx Zc702 TRD and ZED Base TRD
------------------------------------------------------------------
-- logiCVC pixel clock source is now FPGA core logiCLK

SW design differences between the Xilinx Zc702 TRD and ZED TRD
------------------------------------------------------------------
-- u-boot: uses zynq_zed_config
-- dts: uses Zed instead of ZC702, logiCLK added, interrupts changed
-- Kernel sources kernel_logiclk_added.patch: logiCLK driver added
-- Kernel config is inherited from Xilinx and modified with the following options:
        > Device Drivers > Common Clock Framework
            < > Clock driver for SiLabs 570 and compatible devices
            <*> logiCLK driver
        > Device Drivers > USB support > USB Physical Layer drivers
            <*> Xilinx Zynq USB OTG dual-role support
-- ready_to_test/autostart.sh, software/xsdk/video_lib/include/common.h:
   "adv7611 12-004c" is replaced with "adv7611 4-004c"

Building Design:
----------------

Xilinx instructions to Build Hardware and Software for this TRD are available at
http://www.wiki.xilinx.com/Zynq+Base+TRD+2014.4

The instructions above apply in all except building of the u-boot and
the Linux Kernel. Following changes must be used:

        Building u-boot:
                bash> wget https://github.com/Xilinx/u-boot-xlnx/archive/xilinx-v2014.4.tar.gz
                bash> tar xf xilinx-v2014.4.tar.gz
                bash> cd u-boot-xlnx-xilinx-v2014.4
                bash> make ARCH=arm zynq_zed_config
                bash> make ARCH=arm

        Building Linux Kernel:
                bash> cd $HOME
                bash> wget https://github.com/Xilinx/linux-xlnx/archive/xilinx-v2014.4-trd.tar.gz
                bash> tar xf xilinx-v2014.4-trd.tar.gz
                bash> cd linux-xlnx-xilinx-v2014.4-trd
                bash> patch -p1 < $ZYNQ_TRD_HOME/software/patches/kernel_logiclk_added.patch
                bash> cp $ZYNQ_TRD_HOME/software/petalinux/subsystems/linux/configs/kernel/config .config
                bash> make ARCH=arm UIMAGE_LOADADDR=0x8000 uImage
        Building devicetree (No FMC)
                bash> ~/linux-xlnx-xilinx-v2014.4-trd/scripts/dtc/dtc -I dts -O dtb -o devicetree.dtb $ZYNQ_TRD_HOME/software/petalinux/subsystems/linux/configs/device-tree/system-top.dts
        Building devicetree (FMC video in)	
                bash> ~/linux-xlnx-xilinx-v2014.4-trd/scripts/dtc/dtc -I dts -O dtb -o devicetree.dtb $ZYNQ_TRD_HOME/software/petalinux/subsystems/linux/configs/device-tree-fmc-video-in/system-top.dts

        Building Applications:
                Before building, extract: $ZYNQ_TRD_HOME/software/pre-built.tar.gz

The pre compiled files are kept in ready_to_test directory and can be loaded on SD card
root to get started with the design. On Linux boot up the TRD application is
auto loaded and GUI comes on the screen. Here various options can be explored.

For more details on how to Run the TRD please see UG925,User Guide.

6.OTHER INFORMATION

1) Design Notes
	Not applicable.

2) Known Issues
	(1) In TPG selection, when the bouncing box touches the boundary of the
            monitor there is a horizontal line appears on the monitor.

	(2) Occasionally on some hardware set-ups ADV7611 I2C Slave returns NACK for I2C transaction.
            adv7611 4-004c: not an adv7611 on address 0x98
            The workaround is to reboot the system.

7. SUPPORT

To obtain technical support for this reference design, contact Xylon Technical Support at support@logicbricks.com.
Known issues can be also located in the Xilinx Answer Database and on http://zedboard.org/support/documentation/1521.
