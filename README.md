VMIDLE is a small device driver that inserts a HLT instruction into the DOS idle interrupt chain. Under normal circumstances, VMIDLE will reduce CPU usage to zero while DOS is idle.

Once resident, the device driver consumes 32 bytes of memory. As far as I know, a resident DOS device driver can't be any smaller than 32 bytes, including the 18 byte header.

While intended to be used in DOS virtual machines, VMIDLE can be loaded on any system with an x86-compatible processor except for certain buggy Intel i486 DX 100 MHz parts.

To install VMIDLE, copy VMIDLE.SYS to an appropriate directory, e.g. C:\DOS, and add the following line to CONFIG.SYS:

DEVICE=C:\DOS\VMIDLE.SYS

If you have upper memory blocks available, add the following line:

DEVICEHIGH=C:\DOS\VMIDLE.SYS

You can also load VMIDLE.SYS from the command line using an appropriate device loader.

VMIDLE is Copyright (c) 2007, Trevor Scroggins and is licensed under a BSD 2-clause style license. Source code is included. Enjoy!

VMIDLE was written before Microsoft  Windows PE (WinPE), PXE, and (some time later) click-to-run virtualization became the norm. DOS was still widely used to deploy Windows systems, and I developed and maintained DOS-based deployment tools in DOS virtual machines on VMware Workstation, Microsoft Virtual PC, and Microsoft Virtual Server. VMIDLE was intended as a very, very lightweight alternative to other CPU idle TSRs for MS-DOS, FreeDOS, and other DOS compatible systems that would be highly compatible and have minimal impact on my memory budget. A slightly different version of VMIDLE used Microsoft's synthetic version of the HLT instruction (ref: U.S. Pat. No. 7,552,426).   --Trevor Scroggins, 2018.
