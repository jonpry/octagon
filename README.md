octagon
=======

Octagon is a largely MIPS compatible soft-core for fpga's. It it optimized for Xilinx LUT-6 architectures and uses a memory interface similar to MiG generated cores. Required compiler flags are detailed in the code subdirectory. 

Processor is an 8 thread barrel processor. Supporting 1 interrupt mask per thread which can be used by a GIC implemented on the wishbone controller. 

Top module of processor is octagon.vhd
