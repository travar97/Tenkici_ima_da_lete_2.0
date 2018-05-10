#################################################################
# Makefile generated by Xilinx Platform Studio 
# Project:C:\Temp\ra235-2013\ProjekatTenkici\projekat_tenkici\Tenkici_ima_da_lete\battle_city_design\battle_city.xmp
#
# WARNING : This file will be re-generated every time a command
# to run a make target is invoked. So, any changes made to this  
# file manually, will be lost when make is invoked next. 
#################################################################

SHELL = CMD

XILINX_EDK_DIR = C:/Xilinx/14.6/ISE_DS/EDK

SYSTEM = battle_city

MHSFILE = battle_city.mhs

FPGA_ARCH = spartan6

DEVICE = xc6slx45fgg676-2

INTSTYLE = default

XPS_HDL_LANG = vhdl
GLOBAL_SEARCHPATHOPT = 
PROJECT_SEARCHPATHOPT = 

SEARCHPATHOPT = $(PROJECT_SEARCHPATHOPT) $(GLOBAL_SEARCHPATHOPT)

SUBMODULE_OPT = 

PLATGEN_OPTIONS = -p $(DEVICE) -lang $(XPS_HDL_LANG) -intstyle $(INTSTYLE) $(SEARCHPATHOPT) $(SUBMODULE_OPT) -msg __xps/ise/xmsgprops.lst

OBSERVE_PAR_OPTIONS = -error yes

MICROBLAZE_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/microblaze/mb_bootloop.elf
MICROBLAZE_BOOTLOOP_LE = $(XILINX_EDK_DIR)/sw/lib/microblaze/mb_bootloop_le.elf
PPC405_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/ppc405/ppc_bootloop.elf
PPC440_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/ppc440/ppc440_bootloop.elf
BOOTLOOP_DIR = bootloops

MICROBLAZE_0_BOOTLOOP = $(BOOTLOOP_DIR)/microblaze_0.elf
MICROBLAZE_0_ELF_IMP = SDK/SDK_Workspace/battle_city_soft/Debug/battle_city_soft.elf

BRAMINIT_ELF_IMP_FILES = $(MICROBLAZE_0_ELF_IMP)
BRAMINIT_ELF_IMP_FILE_ARGS = -pe microblaze_0 $(MICROBLAZE_0_ELF_IMP)

BRAMINIT_ELF_SIM_FILES = $(MICROBLAZE_0_BOOTLOOP)
BRAMINIT_ELF_SIM_FILE_ARGS = -pe microblaze_0 $(MICROBLAZE_0_BOOTLOOP)

SIM_CMD = isim_battle_city

BEHAVIORAL_SIM_SCRIPT = simulation/behavioral/$(SYSTEM)_setup.tcl

STRUCTURAL_SIM_SCRIPT = simulation/structural/$(SYSTEM)_setup.tcl

TIMING_SIM_SCRIPT = simulation/timing/$(SYSTEM)_setup.tcl

DEFAULT_SIM_SCRIPT = $(BEHAVIORAL_SIM_SCRIPT)

SIMGEN_OPTIONS = -p $(DEVICE) -lang $(XPS_HDL_LANG) -intstyle $(INTSTYLE) $(SEARCHPATHOPT) $(BRAMINIT_ELF_SIM_FILE_ARGS) -msg __xps/ise/xmsgprops.lst -s isim -X C:/Temp/ra235-2013/ProjekatTenkici/projekat_tenkici/Tenkici_ima_da_lete/battle_city_design/


CORE_STATE_DEVELOPMENT_FILES = pcores/battle_city_periph_v1_01_a/hdl/vhdl/battle_city_periph.vhd \
pcores/battle_city_periph_v1_01_a/hdl/vhdl/battle_city.vhd \
pcores/battle_city_periph_v1_01_a/hdl/vhdl/ram.vhd \
pcores/battle_city_periph_v1_01_a/hdl/vhdl/vga_ctrl_a.vhd \
pcores/battle_city_periph_v1_01_a/hdl/vhdl/vga_ctrl_e.vhd \
pcores/battle_city_periph_v1_01_a/hdl/vhdl/clk_gen_100MHz_a.vhd \
pcores/battle_city_periph_v1_01_a/hdl/vhdl/clk_gen_100MHz_e.vhd

WRAPPER_NGC_FILES = implementation/battle_city_proc_sys_reset_0_wrapper.ngc \
implementation/battle_city_microblaze_0_ilmb_wrapper.ngc \
implementation/battle_city_microblaze_0_i_bram_ctrl_wrapper.ngc \
implementation/battle_city_microblaze_0_dlmb_wrapper.ngc \
implementation/battle_city_microblaze_0_d_bram_ctrl_wrapper.ngc \
implementation/battle_city_microblaze_0_bram_block_wrapper.ngc \
implementation/battle_city_microblaze_0_wrapper.ngc \
implementation/battle_city_debug_module_wrapper.ngc \
implementation/battle_city_clock_generator_0_wrapper.ngc \
implementation/battle_city_axi4lite_0_wrapper.ngc \
implementation/battle_city_battle_city_periph_0_wrapper.ngc \
implementation/battle_city_io_periph_wrapper.ngc

POSTSYN_NETLIST = implementation/$(SYSTEM).ngc

SYSTEM_BIT = implementation/$(SYSTEM).bit

DOWNLOAD_BIT = implementation/download.bit

SYSTEM_ACE = implementation/$(SYSTEM).ace

UCF_FILE = data\battle_city.ucf

BMM_FILE = implementation/$(SYSTEM).bmm

BITGEN_UT_FILE = etc/bitgen.ut

XFLOW_OPT_FILE = etc/fast_runtime.opt
XFLOW_DEPENDENCY = __xps/xpsxflow.opt $(XFLOW_OPT_FILE)

XPLORER_DEPENDENCY = __xps/xplorer.opt
XPLORER_OPTIONS = -p $(DEVICE) -uc $(SYSTEM).ucf -bm $(SYSTEM).bmm -max_runs 7

FPGA_IMP_DEPENDENCY = $(BMM_FILE) $(POSTSYN_NETLIST) $(UCF_FILE) $(XFLOW_DEPENDENCY)

SDK_EXPORT_DIR = SDK\SDK_Export\hw
SYSTEM_HW_HANDOFF = $(SDK_EXPORT_DIR)/$(SYSTEM).xml
SYSTEM_HW_HANDOFF_BIT = $(SDK_EXPORT_DIR)/$(SYSTEM).bit
SYSTEM_HW_HANDOFF_BMM = $(SDK_EXPORT_DIR)/$(SYSTEM)_bd.bmm
SYSTEM_HW_HANDOFF_DEP = $(SYSTEM_HW_HANDOFF) $(SYSTEM_HW_HANDOFF_BIT) $(SYSTEM_HW_HANDOFF_BMM)
