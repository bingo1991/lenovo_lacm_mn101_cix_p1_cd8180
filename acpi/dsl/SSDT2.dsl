/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20251212 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT2
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00001400 (5120)
 *     Revision         0x02
 *     Checksum         0x6C
 *     OEM ID           "CIXTEK"
 *     OEM Table ID     "SKY1EDK2"
 *     OEM Revision     0x01000101 (16777473)
 *     Compiler ID      "CIX "
 *     Compiler Version 0x00000001 (1)
 */
DefinitionBlock ("", "SSDT", 2, "CIXTEK", "SKY1EDK2", 0x01000101)
{
    External (_SB_.LPIB, IntObj)
    External (_SB_.LPIL, IntObj)

    Scope (\_SB)
    {
        Device (C000)
        {
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_HID, "ACPI0010" /* Processor Container Device */)  // _HID: Hardware ID
            Device (C001)
            {
                Name (_UID, One)  // _UID: Unique ID
                Name (_HID, "ACPI0010" /* Processor Container Device */)  // _HID: Hardware ID
                Device (CPU0)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, Zero)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIB) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x04, 
                            0xFD, 
                            0x02
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x2000, 
                        0x2000, 
                        0x09D8, 
                        0x09D8, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x000000000659009C, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x0A28
                    })
                }

                Device (CPU1)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIB) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x04, 
                            0xFD, 
                            0x02
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x2000, 
                        0x2000, 
                        0x09D8, 
                        0x09D8, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x000000000659009C, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x0A28
                    })
                }
            }

            Device (C002)
            {
                Name (_UID, 0x02)  // _UID: Unique ID
                Name (_HID, "ACPI0010" /* Processor Container Device */)  // _HID: Hardware ID
                Device (CPU2)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, 0x02)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIL) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x02, 
                            0xFD, 
                            0x04
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x08B8, 
                        0x08B8, 
                        0x03E0, 
                        0x03E0, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000006590094, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x0708
                    })
                }

                Device (CPU3)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, 0x03)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIL) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x02, 
                            0xFD, 
                            0x04
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x08B8, 
                        0x08B8, 
                        0x03E0, 
                        0x03E0, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000006590094, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x0708
                    })
                }

                Device (CPU4)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, 0x04)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIL) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x02, 
                            0xFD, 
                            0x04
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x08B8, 
                        0x08B8, 
                        0x03E0, 
                        0x03E0, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000006590094, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x0708
                    })
                }

                Device (CPU5)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, 0x05)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIL) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x02, 
                            0xFD, 
                            0x04
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x08B8, 
                        0x08B8, 
                        0x03E0, 
                        0x03E0, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000006590094, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x0708
                    })
                }
            }

            Device (C003)
            {
                Name (_UID, 0x03)  // _UID: Unique ID
                Name (_HID, "ACPI0010" /* Processor Container Device */)  // _HID: Hardware ID
                Device (CPU6)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, 0x06)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIB) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x05, 
                            0xFD, 
                            0x02
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x1C4E, 
                        0x1C4E, 
                        0x09D8, 
                        0x09D8, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x00000000065900A0, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x08FC
                    })
                }

                Device (CPU7)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, 0x07)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIB) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x05, 
                            0xFD, 
                            0x02
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x1C4E, 
                        0x1C4E, 
                        0x09D8, 
                        0x09D8, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x00000000065900A0, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x08FC
                    })
                }
            }

            Device (C004)
            {
                Name (_UID, 0x04)  // _UID: Unique ID
                Name (_HID, "ACPI0010" /* Processor Container Device */)  // _HID: Hardware ID
                Device (CPU8)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, 0x08)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIB) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x06, 
                            0xFD, 
                            0x02
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x1B13, 
                        0x1B13, 
                        0x09D8, 
                        0x09D8, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x00000000065900A4, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x0898
                    })
                }

                Device (CPU9)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, 0x09)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIB) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x06, 
                            0xFD, 
                            0x02
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x1B13, 
                        0x1B13, 
                        0x09D8, 
                        0x09D8, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x00000000065900A4, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x0898
                    })
                }
            }

            Device (C005)
            {
                Name (_UID, 0x05)  // _UID: Unique ID
                Name (_HID, "ACPI0010" /* Processor Container Device */)  // _HID: Hardware ID
                Device (CPUA)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, 0x0A)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIB) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x03, 
                            0xFD, 
                            0x02
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x1EC4, 
                        0x1EC4, 
                        0x09D8, 
                        0x09D8, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000006590098, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x09C4
                    })
                }

                Device (CPUB)
                {
                    Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
                    Name (_UID, 0x0B)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
                    {
                        Return (\_SB.LPIB) /* External reference */
                    }

                    Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            0x03, 
                            0xFD, 
                            0x02
                        }
                    })
                    Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
                    {
                        0x17, 
                        0x03, 
                        0x1EC4, 
                        0x1EC4, 
                        0x09D8, 
                        0x09D8, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x20,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000006590098, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000001, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x40,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                0x04,               // Access Size
                                )
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        Zero, 
                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemMemory, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x03E8, 
                        0x0320, 
                        0x09C4
                    })
                }
            }
        }

        Name (CPL0, Package (0x04)
        {
            \_SB.C000.C002.CPU2, 
            \_SB.C000.C002.CPU3, 
            \_SB.C000.C002.CPU4, 
            \_SB.C000.C002.CPU5
        })
        Name (CPM0, Package (0x02)
        {
            \_SB.C000.C003.CPU6, 
            \_SB.C000.C003.CPU7
        })
        Name (CPM1, Package (0x02)
        {
            \_SB.C000.C004.CPU8, 
            \_SB.C000.C004.CPU9
        })
        Name (CPB0, Package (0x02)
        {
            \_SB.C000.C005.CPUA, 
            \_SB.C000.C005.CPUB
        })
        Name (CPB1, Package (0x02)
        {
            \_SB.C000.C001.CPU0, 
            \_SB.C000.C001.CPU1
        })
        Name (CPUL, Package (0x0C)
        {
            \_SB.C000.C001.CPU0, 
            \_SB.C000.C001.CPU1, 
            \_SB.C000.C002.CPU2, 
            \_SB.C000.C002.CPU3, 
            \_SB.C000.C002.CPU4, 
            \_SB.C000.C002.CPU5, 
            \_SB.C000.C003.CPU6, 
            \_SB.C000.C003.CPU7, 
            \_SB.C000.C004.CPU8, 
            \_SB.C000.C004.CPU9, 
            \_SB.C000.C005.CPUA, 
            \_SB.C000.C005.CPUB
        })
    }
}

