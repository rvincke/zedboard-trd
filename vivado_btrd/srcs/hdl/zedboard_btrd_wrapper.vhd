
--*****************************************************************************

-- Date    : 24. 02. 2015.
-- Company : Xylon d.o.o.
-- URL     : https://www.logicbricks.com

-- Title   : ZedBoard Base TRD reference design top module
-- Tool    : Vivado 2014.4

--*****************************************************************************

--*****************************************************************************
--                             LIBRARIES
--*****************************************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

--*****************************************************************************
--                             ENTITY
--*****************************************************************************

entity zedboard_btrd_wrapper is
   port (
      DDR_addr                : inout std_logic_vector(14 downto 0);
      DDR_ba                  : inout std_logic_vector(2 downto 0);
      DDR_cas_n               : inout std_logic;
      DDR_ck_n                : inout std_logic;
      DDR_ck_p                : inout std_logic;
      DDR_cke                 : inout std_logic;
      DDR_cs_n                : inout std_logic;
      DDR_dm                  : inout std_logic_vector(3 downto 0);
      DDR_dq                  : inout std_logic_vector(31 downto 0);
      DDR_dqs_n               : inout std_logic_vector(3 downto 0);
      DDR_dqs_p               : inout std_logic_vector(3 downto 0);
      DDR_odt                 : inout std_logic;
      DDR_ras_n               : inout std_logic;
      DDR_reset_n             : inout std_logic;
      DDR_we_n                : inout std_logic;

      FIXED_IO_ddr_vrn        : inout std_logic;
      FIXED_IO_ddr_vrp        : inout std_logic;
      FIXED_IO_mio            : inout std_logic_vector(53 downto 0);
      FIXED_IO_ps_clk         : inout std_logic;
      FIXED_IO_ps_porb        : inout std_logic;
      FIXED_IO_ps_srstb       : inout std_logic;
 
      fmc_imageon_hdmii_clk   : in    std_logic;
      IO_HDMII_data           : in    std_logic_vector(15 downto 0);
      IO_HDMII_spdif          : in    std_logic;
      fmc_imageon_iic_rst_b   : out   std_logic_vector(0 to 0);
      fmc_imageon_iic_scl_io  : inout std_logic;
      fmc_imageon_iic_sda_io  : inout std_logic;

      hdmio_active_video      : out std_logic;
      hdmio_clk               : out std_logic;
      hdmio_data              : out std_logic_vector(15 downto 0);
      hdmio_hsync             : out std_logic;
      hdmio_vsync             : out std_logic;
      hdmio_int_b             : in  std_logic;

      iic_0_scl_io            : inout std_logic;
      iic_0_sda_io            : inout std_logic;

      otg_reset_n             : out std_logic
   );
end zedboard_btrd_wrapper;

--*****************************************************************************
--                           ARCHITECTURE
--*****************************************************************************

architecture STRUCTURE of zedboard_btrd_wrapper is

   ----------------------------------------------------------------------------
   --                           COMPONENTS
   ----------------------------------------------------------------------------

   component zedboard_btrd is
      port (
         DDR_cas_n               : inout std_logic;
         DDR_cke                 : inout std_logic;
         DDR_ck_n                : inout std_logic;
         DDR_ck_p                : inout std_logic;
         DDR_cs_n                : inout std_logic;
         DDR_reset_n             : inout std_logic;
         DDR_odt                 : inout std_logic;
         DDR_ras_n               : inout std_logic;
         DDR_we_n                : inout std_logic;
         DDR_ba                  : inout std_logic_vector(2 downto 0);
         DDR_addr                : inout std_logic_vector(14 downto 0);
         DDR_dm                  : inout std_logic_vector(3 downto 0);
         DDR_dq                  : inout std_logic_vector(31 downto 0);
         DDR_dqs_n               : inout std_logic_vector(3 downto 0);
         DDR_dqs_p               : inout std_logic_vector(3 downto 0);

         FIXED_IO_mio            : inout std_logic_vector(53 downto 0);
         FIXED_IO_ddr_vrn        : inout std_logic;
         FIXED_IO_ddr_vrp        : inout std_logic;
         FIXED_IO_ps_srstb       : inout std_logic;
         FIXED_IO_ps_clk         : inout std_logic;
         FIXED_IO_ps_porb        : inout std_logic;

         fmc_imageon_hdmii_clk   : in  std_logic;
         IO_HDMII_data           : in  std_logic_vector(15 downto 0);
         IO_HDMII_spdif          : in  std_logic;
         fmc_imageon_iic_rst_b   : out std_logic_vector(0 to 0);
         fmc_imageon_iic_scl_i   : in  std_logic;
         fmc_imageon_iic_scl_o   : out std_logic;
         fmc_imageon_iic_scl_t   : out std_logic;
         fmc_imageon_iic_sda_i   : in  std_logic;
         fmc_imageon_iic_sda_o   : out std_logic;
         fmc_imageon_iic_sda_t   : out std_logic;

         hdmio_active_video      : out std_logic;
         hdmio_clk               : out std_logic;
         hdmio_data              : out std_logic_vector(15 downto 0);
         hdmio_hsync             : out std_logic;
         hdmio_vsync             : out std_logic;
         hdmio_int_b             : in  std_logic;

         IIC_0_scl_i             : in  std_logic;
         IIC_0_scl_o             : out std_logic;
         IIC_0_scl_t             : out std_logic;
         IIC_0_sda_i             : in  std_logic;
         IIC_0_sda_o             : out std_logic;
         IIC_0_sda_t             : out std_logic
      );
   end component zedboard_btrd;

   component IOBUF is
      port (
         I  : in    std_logic;
         O  : out   std_logic;
         T  : in    std_logic;
         IO : inout std_logic
      );
   end component IOBUF;

   signal fmc_imageon_iic_scl_i : std_logic;
   signal fmc_imageon_iic_scl_o : std_logic;
   signal fmc_imageon_iic_scl_t : std_logic;
   signal fmc_imageon_iic_sda_i : std_logic;
   signal fmc_imageon_iic_sda_o : std_logic;
   signal fmc_imageon_iic_sda_t : std_logic;

   signal iic_0_scl_i : std_logic;
   signal iic_0_scl_o : std_logic;
   signal iic_0_scl_t : std_logic;
   signal iic_0_sda_i : std_logic;
   signal iic_0_sda_o : std_logic;
   signal iic_0_sda_t : std_logic;

   signal otg_reset_n_i : std_logic := '1';

begin

   fmc_imageon_iic_scl_iobuf: component IOBUF
       port map (
          I  => fmc_imageon_iic_scl_o,
          IO => fmc_imageon_iic_scl_io,
          O  => fmc_imageon_iic_scl_i,
          T  => fmc_imageon_iic_scl_t
      );

   fmc_imageon_iic_sda_iobuf: component IOBUF
      port map (
         I  => fmc_imageon_iic_sda_o,
         IO => fmc_imageon_iic_sda_io,
         O  => fmc_imageon_iic_sda_i,
         T  => fmc_imageon_iic_sda_t
      );

   iic_0_scl_iobuf: component IOBUF
      port map (
         I  => iic_0_scl_o,
         IO => iic_0_scl_io,
         O  => iic_0_scl_i,
         T  => iic_0_scl_t
      );

   iic_0_sda_iobuf: component IOBUF
      port map (
         I => iic_0_sda_o,
         IO => iic_0_sda_io,
         O => iic_0_sda_i,
         T => iic_0_sda_t
      );

   zedboard_btrd_i: component zedboard_btrd
      port map (
         DDR_addr(14 downto 0)               => DDR_addr(14 downto 0),
         DDR_ba(2 downto 0)                  => DDR_ba(2 downto 0),
         DDR_cas_n                           => DDR_cas_n,
         DDR_ck_n                            => DDR_ck_n,
         DDR_ck_p                            => DDR_ck_p,
         DDR_cke                             => DDR_cke,
         DDR_cs_n                            => DDR_cs_n,
         DDR_dm(3 downto 0)                  => DDR_dm(3 downto 0),
         DDR_dq(31 downto 0)                 => DDR_dq(31 downto 0),
         DDR_dqs_n(3 downto 0)               => DDR_dqs_n(3 downto 0),
         DDR_dqs_p(3 downto 0)               => DDR_dqs_p(3 downto 0),
         DDR_odt                             => DDR_odt,
         DDR_ras_n                           => DDR_ras_n,
         DDR_reset_n                         => DDR_reset_n,
         DDR_we_n                            => DDR_we_n,

         FIXED_IO_ddr_vrn                    => FIXED_IO_ddr_vrn,
         FIXED_IO_ddr_vrp                    => FIXED_IO_ddr_vrp,
         FIXED_IO_mio(53 downto 0)           => FIXED_IO_mio(53 downto 0),
         FIXED_IO_ps_clk                     => FIXED_IO_ps_clk,
         FIXED_IO_ps_porb                    => FIXED_IO_ps_porb,
         FIXED_IO_ps_srstb                   => FIXED_IO_ps_srstb,

         fmc_imageon_hdmii_clk               => fmc_imageon_hdmii_clk,
         IO_HDMII_data(15 downto 0)          => IO_HDMII_data(15 downto 0),
         IO_HDMII_spdif                      => IO_HDMII_spdif,
         fmc_imageon_iic_rst_b(0)            => fmc_imageon_iic_rst_b(0),
         fmc_imageon_iic_scl_i               => fmc_imageon_iic_scl_i,
         fmc_imageon_iic_scl_o               => fmc_imageon_iic_scl_o,
         fmc_imageon_iic_scl_t               => fmc_imageon_iic_scl_t,
         fmc_imageon_iic_sda_i               => fmc_imageon_iic_sda_i,
         fmc_imageon_iic_sda_o               => fmc_imageon_iic_sda_o,
         fmc_imageon_iic_sda_t               => fmc_imageon_iic_sda_t,

         hdmio_active_video                  => hdmio_active_video,
         hdmio_clk                           => hdmio_clk,
         hdmio_data(15 downto 0)             => hdmio_data(15 downto 0),
         hdmio_hsync                         => hdmio_hsync,
         hdmio_vsync                         => hdmio_vsync,
         hdmio_int_b                         => hdmio_int_b,

         IIC_0_scl_i                         => iic_0_scl_i,
         IIC_0_scl_o                         => iic_0_scl_o,
         IIC_0_scl_t                         => iic_0_scl_t,
         IIC_0_sda_i                         => iic_0_sda_i,
         IIC_0_sda_o                         => iic_0_sda_o,
         IIC_0_sda_t                         => iic_0_sda_t
      );

   otg_reset_n <= otg_reset_n_i;

end STRUCTURE;
