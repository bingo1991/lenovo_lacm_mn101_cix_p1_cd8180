/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20251212 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT1
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000030D4 (12500)
 *     Revision         0x02
 *     Checksum         0xF8
 *     OEM ID           "CIXTEK"
 *     OEM Table ID     "SKY1EDK2"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20220331 (539099953)
 */
DefinitionBlock ("", "SSDT", 2, "CIXTEK", "SKY1EDK2", 0x00000001)
{
    External (_SB_.AMTX, MethodObj)    // 2 Arguments
    External (_SB_.DPR1, DeviceObj)
    External (_SB_.DPR2, DeviceObj)
    External (_SB_.DPR4, DeviceObj)
    External (_SB_.DPR5, DeviceObj)
    External (_SB_.GPI4, DeviceObj)
    External (_SB_.GPI5, DeviceObj)
    External (_SB_.HDA_, DeviceObj)
    External (_SB_.I2C0, DeviceObj)
    External (_SB_.I2C1, DeviceObj)
    External (_SB_.I2C2, DeviceObj)
    External (_SB_.I2C3, DeviceObj)
    External (_SB_.I2C4, DeviceObj)
    External (_SB_.I2C6.MXID, IntObj)
    External (_SB_.I2C7, DeviceObj)
    External (_SB_.ISP0, DeviceObj)
    External (_SB_.RMTX, MethodObj)    // 2 Arguments
    External (_SB_.SPFA, MethodObj)    // 0 Arguments
    External (_SB_.SPFM, MethodObj)    // 0 Arguments
    External (_SB_.SPFP, MethodObj)    // 0 Arguments
    External (_SB_.SPI0, DeviceObj)
    External (_SB_.SUB0.CUB0, DeviceObj)
    External (_SB_.SUB1.CUB1, DeviceObj)
    External (_SB_.UCP0, DeviceObj)
    External (_SB_.UCP1, DeviceObj)

    Scope (_SB)
    {
        Scope (\_SB.I2C2)
        {
            Device (RTL5)
            {
                Name (_HID, "RTL5682")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone, 0x0000,
                        "\\_SB.GPI3", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x000A
                        }
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_alc5682_irq", ResourceConsumer, ,)
                    I2cSerialBusV2 (0x001A, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C2",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x04)
                    {
                        Package (0x02)
                        {
                            "realtek,dmic1-data-pin", 
                            One
                        }, 

                        Package (0x02)
                        {
                            "realtek,dmic-clk-pin", 
                            One
                        }, 

                        Package (0x02)
                        {
                            "realtek,dmic-clk-rate-hz", 
                            0x001F4000
                        }, 

                        Package (0x02)
                        {
                            "realtek,jd-src", 
                            One
                        }
                    }
                })
            }
        }

        Device (SNDC)
        {
            Name (_HID, "CIXH6070")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_sndcard", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x00){}
            })
        }

        Scope (\_SB.I2C3)
        {
            Device (RTC0)
            {
                Name (_HID, "RX008900")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0032, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C3",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                        "pinctrl_ra8900ce_irq", ResourceConsumer, ,)
                    GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                        "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x000A
                        }
                })
            }
        }

        Scope (\_SB.I2C0)
        {
            Device (IIS0)
            {
                Name (_HID, "CIXH3024")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0034, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_cam0_hw", ResourceConsumer, ,
                        RawDataBuffer (0x01)  // Vendor Data
                        {
                            0x00
                        })
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_cam0_hw", ResourceConsumer, ,
                        RawDataBuffer (0x01)  // Vendor Data
                        {
                            0x01
                        })
                    GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                        "\\_SB.GPI1", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0009,
                            0x0006
                        }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x06)
                    {
                        Package (0x02)
                        {
                            "actuator-src", 
                            \_SB.I2C0.MTR0
                        }, 

                        Package (0x02)
                        {
                            "isp-src", 
                            \_SB.ISP0
                        }, 

                        Package (0x02)
                        {
                            "cix,camera-module-index", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "reset-gpios", 
                            Package (0x04)
                            {
                                ^IIS0, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pwdn-gpios", 
                            Package (0x04)
                            {
                                ^IIS0, 
                                Zero, 
                                One, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pinctrl-names", 
                            Package (0x02)
                            {
                                "default", 
                                "gpio"
                            }
                        }
                    }
                })
                Name (CLKT, Package (0x01)
                {
                    Package (0x03)
                    {
                        0x48, 
                        "mclk", 
                        \_SB.I2C0.IIS0
                    }
                })
            }

            Device (MTR0)
            {
                Name (_HID, "CIXH3023")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0040, ControllerInitiated, 0x0773593F,
                        AddressingMode7Bit, "\\_SB.I2C0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "pi-max-frequency", 
                            0x0773593F
                        }
                    }
                })
            }
        }

        Scope (\_SB.I2C1)
        {
            Device (IIS2)
            {
                Name (_HID, "CIXH3024")  // _HID: Hardware ID
                Name (_UID, 0x02)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0038, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C1",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_cam2_hw", ResourceConsumer, ,
                        RawDataBuffer (0x01)  // Vendor Data
                        {
                            0x00
                        })
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_cam2_hw", ResourceConsumer, ,
                        RawDataBuffer (0x01)  // Vendor Data
                        {
                            0x01
                        })
                    GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                        "\\_SB.GPI1", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0001,
                            0x0007
                        }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x04)
                    {
                        Package (0x02)
                        {
                            "cix,camera-module-index", 
                            0x02
                        }, 

                        Package (0x02)
                        {
                            "reset-gpios", 
                            Package (0x04)
                            {
                                ^IIS2, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pwdn-gpios", 
                            Package (0x04)
                            {
                                ^IIS2, 
                                Zero, 
                                One, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pinctrl-names", 
                            Package (0x02)
                            {
                                "default", 
                                "gpio"
                            }
                        }
                    }
                })
                Name (CLKT, Package (0x01)
                {
                    Package (0x03)
                    {
                        0x4A, 
                        "mclk", 
                        \_SB.I2C1.IIS2
                    }
                })
            }

            Device (IIS1)
            {
                Name (_HID, "CIXH3024")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_STA, 0x0B)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0036, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C1",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_cam1_hw", ResourceConsumer, ,
                        RawDataBuffer (0x01)  // Vendor Data
                        {
                            0x00
                        })
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_cam1_hw", ResourceConsumer, ,
                        RawDataBuffer (0x01)  // Vendor Data
                        {
                            0x01
                        })
                    GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                        "\\_SB.GPI1", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0011,
                            0x0013
                        }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x04)
                    {
                        Package (0x02)
                        {
                            "cix,camera-module-index", 
                            One
                        }, 

                        Package (0x02)
                        {
                            "reset-gpios", 
                            Package (0x04)
                            {
                                ^IIS1, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pwdn-gpios", 
                            Package (0x04)
                            {
                                ^IIS1, 
                                Zero, 
                                One, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pinctrl-names", 
                            Package (0x02)
                            {
                                "default", 
                                "gpio"
                            }
                        }
                    }
                })
                Name (CLKT, Package (0x01)
                {
                    Package (0x03)
                    {
                        0x49, 
                        "mclk", 
                        \_SB.I2C1.IIS1
                    }
                })
            }
        }

        Device (EC0)
        {
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_HID, "CIXHA015")  // _HID: Hardware ID
            Mutex (ECMX, 0x00)
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (Zero)
            }

            OperationRegion (I2CA, SystemMemory, 0x04070000, 0x0100)
            Field (I2CA, DWordAcc, NoLock, Preserve)
            {
                Offset (0x00), 
                CR,     32, 
                Offset (0x04), 
                SR,     32, 
                Offset (0x08), 
                AR,     32, 
                Offset (0x0C), 
                DR,     32, 
                Offset (0x10), 
                ISR,    32, 
                Offset (0x14), 
                TSR,    32, 
                Offset (0x18), 
                SMPR,   32, 
                Offset (0x1C), 
                TOR,    32, 
                Offset (0x20), 
                IMR,    32, 
                Offset (0x24), 
                IER,    32, 
                Offset (0x28), 
                IDR,    32, 
                Offset (0x2C), 
                GFCR,   32
            }

            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                REST ()
            }

            Method (REST, 0, Serialized)
            {
                IDR = 0x02FF
                Local0 = CR /* \_SB_.EC0_.CR__ */
                Local0 &= 0xFFFFFFFFFFFFFFEF
                Local0 |= 0x40
                CR = Local0
                TSR = Zero
                Local0 = ISR /* \_SB_.EC0_.ISR_ */
                ISR = Local0
                Local0 = SR /* \_SB_.EC0_.SR__ */
                SR = Local0
            }

            Method (STAT, 0, Serialized)
            {
                Local0 = CR /* \_SB_.EC0_.CR__ */
                If (!(Local0 & 0x04))
                {
                    CR = (Local0 | 0x04)
                }

                CLRB ()
                Local1 = 0x000F4240
                While (Local1)
                {
                    Local0 = SR /* \_SB_.EC0_.SR__ */
                    If (!(Local0 & 0x0100))
                    {
                        Break
                    }

                    Local1--
                }

                If ((Local1 == Zero))
                {
                    Return (0x02)
                }

                SETB ()
                Return (Zero)
            }

            Method (STOP, 0, Serialized)
            {
                CLRB ()
                CLRF ()
            }

            Method (READ, 4, Serialized)
            {
                If ((Arg1 == Zero))
                {
                    Return (Zero)
                }

                If ((Arg1 > 0x10))
                {
                    TSR = 0x11
                }
                Else
                {
                    TSR = Arg1
                }

                Local0 = CR /* \_SB_.EC0_.CR__ */
                Local0 |= One
                CR = Local0
                AR = (Arg0 & 0x03FF)
                Local3 = Zero
                While ((Arg1 != Zero))
                {
                    Local0 = ISR /* \_SB_.EC0_.ISR_ */
                    ISR = Local0
                    If ((Local0 & 0x08))
                    {
                        Return (0x02)
                    }

                    If ((Local0 & 0x04))
                    {
                        Return (One)
                    }

                    Local0 &= 0xFFFFFFFFFFFFFFFD
                    Local0 &= 0xFFFFFFFFFFFFFFFE
                    If ((Local0 != Zero))
                    {
                        Return (One)
                    }

                    If ((Arg1 <= 0x10))
                    {
                        Local1 = One
                    }
                    Else
                    {
                        Local1 = Zero
                    }

                    If ((Local1 == One))
                    {
                        If ((SR & 0x20))
                        {
                            Arg2 [Local3] = DR /* \_SB_.EC0_.DR__ */
                            Local3 += One
                            Arg1 -= One
                        }

                        Continue
                    }

                    Local4 = TSR /* \_SB_.EC0_.TSR_ */
                    If ((Local4 != One))
                    {
                        Continue
                    }

                    Local5 = (Arg1 - 0x10)
                    If ((Local5 > 0x10))
                    {
                        TSR = 0x11
                    }
                    Else
                    {
                        TSR = Local5
                    }

                    Local5 = 0x10
                    While ((Local5 != Zero))
                    {
                        Arg2 [Local3] = DR /* \_SB_.EC0_.DR__ */
                        Local3 += One
                        Arg1 -= One
                        Local5 -= One
                    }
                }

                Return (Zero)
            }

            Method (WRIT, 4, Serialized)
            {
                If ((Arg1 == Zero))
                {
                    Return (Zero)
                }

                Local0 = IER /* \_SB_.EC0_.IER_ */
                Local0 |= One
                IER = Local0
                Local0 = CR /* \_SB_.EC0_.CR__ */
                Local0 &= 0xFFFFFFFFFFFFFFFE
                CR = Local0
                Local0 = ISR /* \_SB_.EC0_.ISR_ */
                ISR = Local0
                TSR = Zero
                AR = (Arg0 & 0x03FF)
                Local0 = Zero
                Local1 = Arg1
                DR = DerefOf (Arg2 [Local0])
                Local0++
                Local1--
                While (One)
                {
                    If ((Local1 <= 0x0F))
                    {
                        Local2 = One
                        Local3 = Local1
                    }
                    Else
                    {
                        Local2 = Zero
                        Local3 = 0x0F
                    }

                    Local4 = Local3
                    While ((Local4 > Zero))
                    {
                        DR = DerefOf (Arg2 [Local0])
                        Local1--
                        Local4--
                        Local0++
                    }

                    If (Local2)
                    {
                        TSR = (Local3 + One)
                    }
                    Else
                    {
                        TSR = Local3
                    }

                    Local5 = 0x000F4240
                    While (One)
                    {
                        Local6 = ISR /* \_SB_.EC0_.ISR_ */
                        ISR = Local6
                        Local6 &= 0xFFFFFFFFFFFFFFFD
                        Local5--
                        If (((Local5 == Zero) || (Local6 != Zero)))
                        {
                            Break
                        }
                    }

                    If ((Local5 == Zero))
                    {
                        Return (0x02)
                    }

                    If ((Local6 & 0xFFFFFFFFFFFFFFFE))
                    {
                        If ((Local6 & 0x08))
                        {
                            Return (0x02)
                        }

                        If ((Local6 & 0x40))
                        {
                            CLRF ()
                        }

                        Return (One)
                    }

                    If (Local2)
                    {
                        Return (Zero)
                    }
                }

                Return (Zero)
            }

            Method (CKSB, 1, Serialized)
            {
                Local0 = SizeOf (Arg0)
                Local1 = Zero
                Local2 = Zero
                While ((Local1 < Local0))
                {
                    If ((Local1 != One))
                    {
                        Mid (Arg0, Local1, One, Local3)
                        Local2 += ToInteger (Local3)
                    }

                    Local1++
                }

                Return ((0x0100 - (Local2 & 0xFF)))
            }

            Method (CLRB, 0, Serialized)
            {
                Local0 = CR /* \_SB_.EC0_.CR__ */
                If ((Local0 & 0x10))
                {
                    CR = (Local0 & 0xFFFFFFFFFFFFFFEF)
                }
            }

            Method (SETB, 0, Serialized)
            {
                Local0 = CR /* \_SB_.EC0_.CR__ */
                If (!(Local0 & 0x10))
                {
                    CR = (Local0 | 0x10)
                }
            }

            Method (CLRF, 0, Serialized)
            {
                Local0 = CR /* \_SB_.EC0_.CR__ */
                CR = (Local0 | 0x40)
                While ((CR & 0x40)){}
            }

            Method (TRAS, 4, Serialized)
            {
                Acquire (ECMX, 0xFFFF)
                If (\_SB.AMTX (\_SB.I2C6.MXID, 0x1A))
                {
                    Return (One)
                }

                Local0 = Zero
                While (One)
                {
                    If ((STAT () != Zero))
                    {
                        Break
                    }

                    CLRF ()
                    Local1 = ISR /* \_SB_.EC0_.ISR_ */
                    ISR = Local1
                    If ((WRIT (0x76, Arg1, Arg0, Zero) != Zero))
                    {
                        Break
                    }

                    If ((READ (0x76, Arg3, Arg2, One) != Zero))
                    {
                        Break
                    }

                    Local0 = One
                    Break
                }

                If ((Local0 == Zero))
                {
                    REST ()
                    STOP ()
                    \_SB.RMTX (\_SB.I2C6.MXID, 0x1A)
                    Release (ECMX)
                    Return (One)
                }

                \_SB.RMTX (\_SB.I2C6.MXID, 0x1A)
                Release (ECMX)
                CreateByteField (Arg2, One, LENG)
                If ((LENG != Arg3))
                {
                    Return (One)
                }

                CreateByteField (Arg2, 0x03, CSUM)
                Mid (Arg2, 0x02, (LENG - 0x02), Local1)
                If ((CSUM != (CKSB (Local1) & 0xFF)))
                {
                    Return (One)
                }

                Return (Zero)
            }

            Method (EVNT, 0, Serialized)
            {
                Name (BUF0, Buffer (0x09)
                {
                    /* 0000 */  0xDA, 0x03, 0xA8, 0x00, 0x55, 0x00, 0x00, 0x00,  // ....U...
                    /* 0008 */  0x00                                             // .
                })
                Name (BUF1, Buffer (0x0F){})
                If ((TRAS (BUF0, SizeOf (BUF0), BUF1, 0x0F) == Zero))
                {
                    CreateByteField (BUF1, 0x0A, TYPE)
                    CreateDWordField (BUF1, 0x0B, DATA)
                    Local0 = DATA /* \_SB_.EC0_.EVNT.DATA */
                    Local0 = (((((Local0 & 0xFF) << 0x18) | (
                        (Local0 & 0xFF00) << 0x08)) | ((Local0 & 0x00FF0000) >> 0x08
                        )) | ((Local0 & 0xFF000000) >> 0x18))
                    NTII (Local0)
                }
            }

            Method (NTII, 1, Serialized)
            {
                If ((Arg0 & 0x0200)){}
                If ((Arg0 & 0x0400)){}
                If ((Arg0 & 0x0800)){}
            }

            Method (WRGP, 2, Serialized)
            {
                Name (BUF0, Buffer (0x0B)
                {
                    /* 0000 */  0xDA, 0x03, 0x00, 0x00, 0x92, 0x00, 0x00, 0x00,  // ........
                    /* 0008 */  0x02, 0x00, 0x00                                 // ...
                })
                CreateByteField (BUF0, 0x02, CSUM)
                CreateByteField (BUF0, 0x09, GNUM)
                CreateByteField (BUF0, 0x0A, GVAL)
                GNUM = Arg0
                GVAL = Arg1
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                Name (BUF1, Buffer (0x0B){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
            }

            Method (RDGP, 1, Serialized)
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0x00, 0x00, 0x93, 0x00, 0x00, 0x00,  // ........
                    /* 0008 */  0x01, 0x00                                       // ..
                })
                CreateByteField (BUF0, 0x02, CSUM)
                CreateByteField (BUF0, 0x09, GNUM)
                GNUM = Arg0
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                Name (BUF1, Buffer (0x0B){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
                Sleep (0x14)
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
                CreateByteField (BUF1, 0x0A, GVAL)
                Return (GVAL) /* \_SB_.EC0_.RDGP.GVAL */
            }

            Method (GKBL, 0, Serialized)
            {
                Name (BUF0, Buffer (0x09)
                {
                    /* 0000 */  0xDA, 0x03, 0x00, 0x00, 0x22, 0x00, 0x00, 0x00,  // ...."...
                    /* 0008 */  0x00                                             // .
                })
                CreateByteField (BUF0, 0x02, CSUM)
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                Name (BUF1, Buffer (0x0C){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
                CreateByteField (BUF1, 0x0A, KBLP)
                CreateByteField (BUF1, 0x0B, KBLE)
                Return (Package (0x02)
                {
                    KBLP, 
                    KBLE
                })
            }

            Method (SKBL, 1, Serialized)
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00,  // ....#...
                    /* 0008 */  0x01, 0x00                                       // ..
                })
                CreateByteField (BUF0, 0x02, CSUM)
                CreateByteField (BUF0, 0x09, KBLP)
                KBLP = Arg0
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                Name (BUF1, Buffer (0x0B){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
            }

            Method (GLSS, 0, Serialized)
            {
                Name (BUF0, Buffer (0x09)
                {
                    /* 0000 */  0xDA, 0x03, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00,  // ....2...
                    /* 0008 */  0x00                                             // .
                })
                CreateByteField (BUF0, 0x02, CSUM)
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                Name (BUF1, Buffer (0x0F){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
                CreateByteField (BUF1, 0x0A, LSST)
                CreateDWordField (BUF1, 0x0B, LSSV)
                Return (Package (0x02)
                {
                    LSST, 
                    LSSV
                })
            }

            Method (SFAT, 0, Serialized)
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0xA9, 0x00, 0x52, 0x00, 0x00, 0x00,  // ....R...
                    /* 0008 */  0x01, 0x01                                       // ..
                })
                Name (BUF1, Buffer (0x0A){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
            }

            Method (SFMT, 0, Serialized)
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0xA8, 0x00, 0x52, 0x00, 0x00, 0x00,  // ....R...
                    /* 0008 */  0x01, 0x02                                       // ..
                })
                Name (BUF1, Buffer (0x0A){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
            }

            Method (SFMN, 0, Serialized)
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0xAA, 0x00, 0x52, 0x00, 0x00, 0x00,  // ....R...
                    /* 0008 */  0x01, 0x00                                       // ..
                })
                Name (BUF1, Buffer (0x0A){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
            }

            Method (SFPF, 0, Serialized)
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0xA6, 0x00, 0x52, 0x00, 0x00, 0x00,  // ....R...
                    /* 0008 */  0x01, 0x04                                       // ..
                })
                Name (BUF1, Buffer (0x0A){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
            }

            Method (SFPW, 3, Serialized)
            {
                If ((Arg0 > 0x64))
                {
                    Return (One)
                }

                \_SB.EC0.SFMN ()
                Name (BUF0, Buffer (0x0D)
                {
                    /* 0000 */  0xDA, 0x03, 0x00, 0x00, 0x25, 0x00, 0x00, 0x00,  // ....%...
                    /* 0008 */  0x04, 0x00, 0x00, 0x00, 0x00                     // .....
                })
                Name (BUF1, Buffer (0x0A){})
                CreateByteField (BUF0, 0x02, CSUM)
                CreateByteField (BUF0, 0x0A, DUTY)
                CreateByteField (BUF0, 0x0B, PWMT)
                CreateByteField (BUF0, 0x0C, INDX)
                DUTY = Arg0
                PWMT = Arg1
                INDX = Arg2
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                If ((\_SB.EC0.TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1)) != Zero))
                {
                    Return (0x02)
                }

                Return (Zero)
            }

            Method (GFPW, 2, Serialized)
            {
                Name (BUF0, Buffer (0x0B)
                {
                    /* 0000 */  0xDA, 0x03, 0xD5, 0x00, 0x26, 0x00, 0x00, 0x00,  // ....&...
                    /* 0008 */  0x02, 0x00, 0x00                                 // ...
                })
                CreateByteField (BUF0, 0x02, CSUM)
                CreateByteField (BUF0, 0x09, PWMT)
                CreateByteField (BUF0, 0x0A, INDX)
                PWMT = Arg0
                INDX = Arg1
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                Name (BUF1, Buffer (0x0C){})
                CreateByteField (BUF1, 0x0B, DUTY)
                If ((\_SB.EC0.TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1)) == Zero))
                {
                    Return (DUTY) /* \_SB_.EC0_.GFPW.DUTY */
                }

                Return (0xFFFFFFFF)
            }
        }

        Device (AC)
        {
            Name (_HID, "ACPI0003" /* Power Source Device */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                \_SB
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
            {
                Return (One)
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }
        }

        Scope (\_SB.GPI5)
        {
            Name (_AEI, ResourceTemplate ()  // _AEI: ACPI Event Interrupts
            {
                GpioInt (Edge, ActiveHigh, Exclusive, PullUp, 0x0000,
                    "\\_SB.GPI5", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0001
                    }
            })
            Method (_E01, 0, NotSerialized)  // _Exx: Edge-Triggered GPE, xx=0x00-0xFF
            {
                Notify (\_SB.PWRB, 0x80) // Status Change
            }
        }

        Scope (\_SB.SPI0)
        {
            Device (TP3)
            {
                Name (_HID, "SPT0002")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, ResourceTemplate ()
                    {
                        SpiSerialBusV2 (0x0000, PolarityLow, FourWireMode, 0x08,
                            ControllerInitiated, 0x0007A120, ClockPolarityLow,
                            ClockPhaseFirst, "\\_SB.SPI0",
                            0x00, ResourceConsumer, , Exclusive,
                            )
                    })
                    Return (RBUF) /* \_SB_.SPI0.TP3_._CRS.RBUF */
                }
            }

            Device (TP4)
            {
                Name (_HID, "SPT0002")  // _HID: Hardware ID
                Name (_UID, 0x02)  // _UID: Unique ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, ResourceTemplate ()
                    {
                        SpiSerialBusV2 (0x0001, PolarityLow, FourWireMode, 0x08,
                            ControllerInitiated, 0x0007A120, ClockPolarityLow,
                            ClockPhaseFirst, "\\_SB.SPI0",
                            0x00, ResourceConsumer, , Exclusive,
                            )
                    })
                    Return (RBUF) /* \_SB_.SPI0.TP4_._CRS.RBUF */
                }
            }
        }

        Scope (\_SB.I2C7)
        {
            Device (PD00)
            {
                Name (_HID, "CIXH200D")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0030, ControllerInitiated, 0x000186A0,
                        AddressingMode7Bit, "\\_SB.I2C7",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                        "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0007
                        }
                })
                Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "id", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "usbc_con0", 
                            "UC00"
                        }
                    }
                })
                Name (UC00, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "data-role", 
                            "host"
                        }, 

                        Package (0x02)
                        {
                            "power-role", 
                            "source"
                        }, 

                        Package (0x02)
                        {
                            "try-power-role", 
                            "source"
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "port@0", 
                            "PRT0"
                        }, 

                        Package (0x02)
                        {
                            "port@1", 
                            "PRT1"
                        }, 

                        Package (0x02)
                        {
                            "port@2", 
                            "PRT2"
                        }
                    }
                })
                Name (PRT0, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP00"
                        }
                    }
                })
                Name (EP00, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x03)
                            {
                                \_SB.SUB0.CUB0, 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (PRT1, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            One
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP01"
                        }
                    }
                })
                Name (EP01, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x03)
                            {
                                \_SB.UCP0, 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (PRT2, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            0x02
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@1", 
                            "EP02"
                        }
                    }
                })
                Name (EP02, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            One
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x03)
                            {
                                \_SB.UCP0, 
                                "port@0", 
                                "endpoint@1"
                            }
                        }
                    }
                })
            }

            Device (PD01)
            {
                Name (_HID, "CIXH200D")  // _HID: Hardware ID
                Name (_UID, 0x02)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0031, ControllerInitiated, 0x000186A0,
                        AddressingMode7Bit, "\\_SB.I2C7",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                        "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0007
                        }
                })
                Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "id", 
                            One
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "usbc_con1", 
                            "UC00"
                        }
                    }
                })
                Name (UC00, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "data-role", 
                            "host"
                        }, 

                        Package (0x02)
                        {
                            "power-role", 
                            "source"
                        }, 

                        Package (0x02)
                        {
                            "try-power-role", 
                            "source"
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "port@0", 
                            "PRT0"
                        }, 

                        Package (0x02)
                        {
                            "port@1", 
                            "PRT1"
                        }, 

                        Package (0x02)
                        {
                            "port@2", 
                            "PRT2"
                        }
                    }
                })
                Name (PRT0, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP00"
                        }
                    }
                })
                Name (EP00, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x03)
                            {
                                \_SB.SUB1.CUB1, 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (PRT1, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            One
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP01"
                        }
                    }
                })
                Name (EP01, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x03)
                            {
                                \_SB.UCP1, 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (PRT2, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            0x02
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@1", 
                            "EP02"
                        }
                    }
                })
                Name (EP02, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            One
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x03)
                            {
                                \_SB.UCP1, 
                                "port@0", 
                                "endpoint@1"
                            }
                        }
                    }
                })
            }
        }

        Device (MUX0)
        {
            Name (_HID, "CIXHA016")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04170000,         // Address Base
                    0x00001000,         // Address Length
                    )
                PinGroup ("pinctrl_sndcard", ResourceProducer, ,
                    RawDataBuffer (0x10)  // Vendor Data
                    {
                        0x02, 0x00, 0x00, 0x24, 0x02, 0x04, 0x00, 0x24, 
                        0x02, 0x08, 0x00, 0x24, 0x02, 0x0C, 0x00, 0x24
                    })
                    {   // Pin list
                        0x0080,
                        0x0081,
                        0x0082,
                        0x0083
                    }
                PinGroup ("pinctrl_fch_pwm0", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0x50, 0x00, 0x07
                    })
                    {   // Pin list
                        0x0014
                    }
                PinGroup ("pinctrl_fch_pwm1", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x01, 0x3C, 0x00, 0xB7
                    })
                    {   // Pin list
                        0x004F
                    }
                PinGroup ("pinctrl_fch_pwm2", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x01, 0x40, 0x00, 0xB7
                    })
                    {   // Pin list
                        0x0050
                    }
                PinGroup ("pinctrl_fch_pwm3", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x01, 0x4C, 0x00, 0xD7
                    })
                    {   // Pin list
                        0x0053
                    }
                PinGroup ("pinctrl_fch_pwm5", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x01, 0x44, 0x00, 0xD7
                    })
                    {   // Pin list
                        0x0051
                    }
                PinGroup ("pinctrl_edp0", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x48, 0x00, 0x24, 0x00, 0x4C, 0x00, 0x24
                    })
                    {   // Pin list
                        0x0012,
                        0x0013
                    }
                PinGroup ("pinctrl_cam0_hw", ResourceProducer, ,
                    RawDataBuffer (0x0C)  // Vendor Data
                    {
                        0x01, 0x94, 0x00, 0x3C, 0x01, 0x10, 0x00, 0xDC, 
                        0x01, 0x04, 0x00, 0xDC
                    })
                    {   // Pin list
                        0x0065,
                        0x0044,
                        0x0041
                    }
                PinGroup ("pinctrl_cam1_hw", ResourceProducer, ,
                    RawDataBuffer (0x0C)  // Vendor Data
                    {
                        0x01, 0x98, 0x00, 0x3C, 0x01, 0x30, 0x00, 0x1C, 
                        0x01, 0x38, 0x00, 0x1C
                    })
                    {   // Pin list
                        0x0066,
                        0x004C,
                        0x004E
                    }
                PinGroup ("pinctrl_cam2_hw", ResourceProducer, ,
                    RawDataBuffer (0x0C)  // Vendor Data
                    {
                        0x01, 0x9C, 0x00, 0x3C, 0x00, 0xF0, 0x00, 0xDC, 
                        0x01, 0x08, 0x00, 0xDC
                    })
                    {   // Pin list
                        0x0067,
                        0x003C,
                        0x0042
                    }
                PinGroup ("pinctrl_cam3_hw", ResourceProducer, ,
                    RawDataBuffer (0x0C)  // Vendor Data
                    {
                        0x01, 0xA0, 0x00, 0x3C, 0x01, 0x20, 0x00, 0xBC, 
                        0x01, 0x24, 0x00, 0xBC
                    })
                    {   // Pin list
                        0x0068,
                        0x0048,
                        0x0049
                    }
                PinGroup ("pinctrl_lt7911_hw", ResourceProducer, ,
                    RawDataBuffer (0x10)  // Vendor Data
                    {
                        0x01, 0x1C, 0x00, 0x8C, 0x01, 0x28, 0x00, 0x0C, 
                        0x01, 0x2C, 0x00, 0x0C, 0x01, 0x34, 0x00, 0x1C
                    })
                    {   // Pin list
                        0x0047,
                        0x004A,
                        0x004B,
                        0x004D
                    }
                PinGroup ("gmac0", ResourceProducer, ,
                    RawDataBuffer (0x3C)  // Vendor Data
                    {
                        0x01, 0xA4, 0x00, 0x9C, 0x01, 0xA8, 0x00, 0x9C, 
                        0x01, 0xAC, 0x00, 0x9C, 0x01, 0xB0, 0x00, 0x9C, 
                        0x01, 0xB4, 0x00, 0x9C, 0x01, 0xB8, 0x00, 0x9C, 
                        0x01, 0xBC, 0x00, 0x94, 0x01, 0xC0, 0x00, 0x94, 
                        0x01, 0xC4, 0x00, 0x94, 0x01, 0xC8, 0x00, 0x94, 
                        0x01, 0xCC, 0x00, 0x94, 0x01, 0xD0, 0x00, 0x94, 
                        0x01, 0xD4, 0x00, 0x94, 0x01, 0xD8, 0x00, 0x9C, 
                        0x01, 0xDC, 0x00, 0x9C
                    })
                    {   // Pin list
                        0x0069,
                        0x006A,
                        0x006B,
                        0x006C,
                        0x006D,
                        0x006E,
                        0x006F,
                        0x0070,
                        0x0071,
                        0x0072,
                        0x0073,
                        0x0074,
                        0x0075,
                        0x0076,
                        0x0077
                    }
                PinGroup ("gmac0-init", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x01, 0xD8, 0x00, 0x9C, 0x01, 0xDC, 0x00, 0x9C
                    })
                    {   // Pin list
                        0x0076,
                        0x0077
                    }
                PinGroup ("pinctrl_fch_i2c0", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x78, 0x00, 0x47, 0x00, 0x7C, 0x00, 0x47
                    })
                    {   // Pin list
                        0x001E,
                        0x001F
                    }
                PinGroup ("pinctrl_fch_i2c2", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x88, 0x00, 0x5C, 0x00, 0x8C, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x0022,
                        0x0023
                    }
                PinGroup ("pinctrl_fch_i2c3", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x94, 0x00, 0x5C, 0x00, 0x98, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x0025,
                        0x0026
                    }
                PinGroup ("pinctrl_fch_i2c4", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0xA0, 0x00, 0x5C, 0x00, 0xA4, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x0028,
                        0x0029
                    }
                PinGroup ("pinctrl_fch_i2c5", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x68, 0x00, 0x5C, 0x00, 0x6C, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x001A,
                        0x001B
                    }
                PinGroup ("pinctrl_fch_spi1", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x01, 0xE8, 0x01, 0x5C, 0x01, 0xEC, 0x01, 0x5C, 
                        0x01, 0xF0, 0x01, 0x5C, 0x01, 0xF4, 0x01, 0x5C, 
                        0x01, 0xF8, 0x01, 0x1C
                    })
                    {   // Pin list
                        0x007A,
                        0x007B,
                        0x007C,
                        0x007D,
                        0x007E
                    }
                PinGroup ("pinctrl_fch_uart0", ResourceProducer, ,
                    RawDataBuffer (0x10)  // Vendor Data
                    {
                        0x01, 0x3C, 0x00, 0x37, 0x01, 0x40, 0x00, 0x37, 
                        0x01, 0x44, 0x00, 0x37, 0x01, 0x48, 0x00, 0x37
                    })
                    {   // Pin list
                        0x004F,
                        0x0050,
                        0x0051,
                        0x0052
                    }
                PinGroup ("pinctrl_fch_uart1", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x01, 0x4C, 0x00, 0x37, 0x01, 0x50, 0x00, 0x37
                    })
                    {   // Pin list
                        0x0053,
                        0x0054
                    }
                PinGroup ("pinctrl_fch_uart2", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x01, 0x5C, 0x00, 0x27, 0x01, 0x60, 0x00, 0x27
                    })
                    {   // Pin list
                        0x0057,
                        0x0058
                    }
                PinGroup ("pinctrl_fch_uart3", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x01, 0x64, 0x00, 0x37, 0x01, 0x68, 0x00, 0x37
                    })
                    {   // Pin list
                        0x0059,
                        0x005A
                    }
                PinGroup ("pinctrl_hda", ResourceProducer, ,
                    RawDataBuffer (0x1C)  // Vendor Data
                    {
                        0x00, 0xA8, 0x00, 0x3C, 0x00, 0xAC, 0x00, 0x3C, 
                        0x00, 0xB0, 0x00, 0x3C, 0x00, 0xB4, 0x00, 0x5C, 
                        0x00, 0xB8, 0x00, 0x5C, 0x00, 0xBC, 0x00, 0x3C, 
                        0x00, 0xC0, 0x00, 0x3C
                    })
                    {   // Pin list
                        0x002A,
                        0x002B,
                        0x002C,
                        0x002D,
                        0x002E,
                        0x002F,
                        0x0030
                    }
                PinGroup ("pinctrl_substrate_i2s0", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x00, 0xA8, 0x00, 0xBC, 0x00, 0xAC, 0x00, 0xBC, 
                        0x00, 0xB0, 0x00, 0xBC, 0x00, 0xB4, 0x00, 0xDC, 
                        0x00, 0xB8, 0x00, 0xDC
                    })
                    {   // Pin list
                        0x002A,
                        0x002B,
                        0x002C,
                        0x002D,
                        0x002E
                    }
                PinGroup ("pinctrl_substrate_i2s1", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x00, 0xC4, 0x00, 0x3C, 0x00, 0xC8, 0x00, 0x3C, 
                        0x00, 0xCC, 0x00, 0x5C, 0x00, 0xD0, 0x00, 0x3C, 
                        0x00, 0xD4, 0x00, 0x3C
                    })
                    {   // Pin list
                        0x0031,
                        0x0032,
                        0x0033,
                        0x0034,
                        0x0035
                    }
                PinGroup ("pinctrl_substrate_i2s2", ResourceProducer, ,
                    RawDataBuffer (0x2C)  // Vendor Data
                    {
                        0x00, 0xD8, 0x00, 0x3C, 0x00, 0xDC, 0x00, 0x3C, 
                        0x00, 0xE0, 0x00, 0x5C, 0x00, 0xE4, 0x00, 0x3C, 
                        0x00, 0xE8, 0x00, 0x5C, 0x00, 0xEC, 0x00, 0x3C, 
                        0x00, 0xF0, 0x00, 0x3C, 0x00, 0xF4, 0x00, 0x5C, 
                        0x00, 0xF8, 0x00, 0x5C, 0x00, 0xFC, 0x00, 0x5C, 
                        0x01, 0x00, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x0036,
                        0x0037,
                        0x0038,
                        0x0039,
                        0x003A,
                        0x003B,
                        0x003C,
                        0x003D,
                        0x003E,
                        0x003F,
                        0x0040
                    }
                PinGroup ("pinctrl_substrate_i2s3", ResourceProducer, ,
                    RawDataBuffer (0x24)  // Vendor Data
                    {
                        0x01, 0x04, 0x00, 0x3C, 0x01, 0x08, 0x00, 0x3C, 
                        0x01, 0x0C, 0x00, 0x5C, 0x01, 0x10, 0x00, 0x3C, 
                        0x01, 0x14, 0x00, 0x5C, 0x01, 0x18, 0x00, 0x3C, 
                        0x01, 0x1C, 0x00, 0x3C, 0x01, 0x20, 0x00, 0x5C, 
                        0x01, 0x24, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x0041,
                        0x0042,
                        0x0043,
                        0x0044,
                        0x0045,
                        0x0046,
                        0x0047,
                        0x0048,
                        0x0049
                    }
                PinGroup ("pinctrl_substrate_i2s4", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x01, 0x28, 0x00, 0x9C, 0x01, 0x2C, 0x00, 0x9C, 
                        0x01, 0x30, 0x00, 0x9C, 0x01, 0x34, 0x00, 0x9C, 
                        0x01, 0x38, 0x00, 0x9C
                    })
                    {   // Pin list
                        0x004A,
                        0x004B,
                        0x004C,
                        0x004D,
                        0x004E
                    }
                PinGroup ("pinctrl_substrate_i2s5", ResourceProducer, ,
                    RawDataBuffer (0x20)  // Vendor Data
                    {
                        0x00, 0xDC, 0x01, 0x3C, 0x00, 0xE0, 0x01, 0x5C, 
                        0x00, 0xE4, 0x01, 0x3C, 0x00, 0xE8, 0x01, 0x3C, 
                        0x00, 0xEC, 0x01, 0x3C, 0x00, 0xF0, 0x01, 0x3C, 
                        0x00, 0xF4, 0x01, 0x5C, 0x00, 0xF8, 0x01, 0x5C
                    })
                    {   // Pin list
                        0x0037,
                        0x0038,
                        0x0039,
                        0x003A,
                        0x003B,
                        0x003C,
                        0x003D,
                        0x003E
                    }
                PinGroup ("pinctrl_substrate_i2s6", ResourceProducer, ,
                    RawDataBuffer (0x20)  // Vendor Data
                    {
                        0x00, 0xDC, 0x01, 0xBC, 0x00, 0xE0, 0x01, 0xDC, 
                        0x00, 0xE4, 0x01, 0xBC, 0x00, 0xE8, 0x01, 0xBC, 
                        0x00, 0xEC, 0x01, 0xBC, 0x00, 0xF0, 0x01, 0xBC, 
                        0x00, 0xF4, 0x01, 0xDC, 0x00, 0xF8, 0x01, 0xDC
                    })
                    {   // Pin list
                        0x0037,
                        0x0038,
                        0x0039,
                        0x003A,
                        0x003B,
                        0x003C,
                        0x003D,
                        0x003E
                    }
                PinGroup ("pinctrl_substrate_i2s7", ResourceProducer, ,
                    RawDataBuffer (0x20)  // Vendor Data
                    {
                        0x01, 0x08, 0x01, 0x3C, 0x01, 0x0C, 0x01, 0x5C, 
                        0x01, 0x10, 0x01, 0x3C, 0x01, 0x14, 0x01, 0x5C, 
                        0x01, 0x18, 0x01, 0x3C, 0x01, 0x1C, 0x01, 0x3C, 
                        0x01, 0x20, 0x01, 0x5C, 0x01, 0x24, 0x01, 0x5C
                    })
                    {   // Pin list
                        0x0042,
                        0x0043,
                        0x0044,
                        0x0045,
                        0x0046,
                        0x0047,
                        0x0048,
                        0x0049
                    }
                PinGroup ("pinctrl_substrate_i2s8", ResourceProducer, ,
                    RawDataBuffer (0x20)  // Vendor Data
                    {
                        0x01, 0x08, 0x01, 0xBC, 0x01, 0x0C, 0x01, 0xDC, 
                        0x01, 0x10, 0x01, 0xBC, 0x01, 0x14, 0x01, 0xDC, 
                        0x01, 0x18, 0x01, 0xBC, 0x01, 0x1C, 0x01, 0xBC, 
                        0x01, 0x20, 0x01, 0xDC, 0x01, 0x24, 0x01, 0xDC
                    })
                    {   // Pin list
                        0x0042,
                        0x0043,
                        0x0044,
                        0x0045,
                        0x0046,
                        0x0047,
                        0x0048,
                        0x0049
                    }
                PinGroup ("pinctrl_alc5682_irq", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x02, 0x14, 0x00, 0x1C
                    })
                    {   // Pin list
                        0x0085
                    }
                PinGroup ("pinctrl_fch_i3c0", ResourceProducer, ,
                    RawDataBuffer (0x0C)  // Vendor Data
                    {
                        0x00, 0x88, 0x00, 0xDC, 0x00, 0x8C, 0x00, 0xDC, 
                        0x00, 0x90, 0x00, 0xDC
                    })
                    {   // Pin list
                        0x0022,
                        0x0023,
                        0x0024
                    }
                PinGroup ("pinctrl_fch_i3c1", ResourceProducer, ,
                    RawDataBuffer (0x0C)  // Vendor Data
                    {
                        0x00, 0x94, 0x00, 0xDC, 0x00, 0x98, 0x00, 0xDC, 
                        0x00, 0x9C, 0x00, 0xDC
                    })
                    {   // Pin list
                        0x0025,
                        0x0026,
                        0x0027
                    }
                PinGroup ("pinctrl_dp_to_hdmi_ps185", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xE8, 0x00, 0xC4
                    })
                    {   // Pin list
                        0x003A
                    }
                PinGroup ("pinctrl_hog_s0", ResourceProducer, ,
                    RawDataBuffer (0x30)  // Vendor Data
                    {
                        0x00, 0x8C, 0x01, 0x44, 0x00, 0x88, 0x01, 0x44, 
                        0x01, 0x64, 0x00, 0xC4, 0x01, 0x68, 0x00, 0xC4, 
                        0x01, 0x50, 0x01, 0x44, 0x00, 0x6C, 0x00, 0xC4, 
                        0x00, 0x68, 0x00, 0xC4, 0x00, 0x90, 0x00, 0x44, 
                        0x00, 0x9C, 0x00, 0x44, 0x00, 0xA0, 0x00, 0xC4, 
                        0x00, 0xA4, 0x00, 0xC4, 0x00, 0xE4, 0x00, 0xC4
                    })
                    {   // Pin list
                        0x0023,
                        0x0022,
                        0x0059,
                        0x005A,
                        0x0054,
                        0x001B,
                        0x001A,
                        0x0024,
                        0x0027,
                        0x0028,
                        0x0029,
                        0x0039
                    }
            })
        }

        Device (MUX1)
        {
            Name (_HID, "CIXHA017")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x16007000,         // Address Base
                    0x00001000,         // Address Length
                    )
                PinGroup ("wifi_vbat_gpio", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0x30, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x000C
                    }
                PinGroup ("i2c0_grp", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x70, 0x00, 0x5C, 0x00, 0x74, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x001C,
                        0x001D
                    }
                PinGroup ("i2c1_grp", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x78, 0x00, 0x57, 0x00, 0x7C, 0x00, 0x57
                    })
                    {   // Pin list
                        0x001E,
                        0x001F
                    }
                PinGroup ("pinctrl_fch_spi0", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x00, 0xA8, 0x00, 0x5C, 0x00, 0xAC, 0x00, 0x5C, 
                        0x00, 0xB0, 0x00, 0x5C, 0x00, 0xB4, 0x00, 0x5C, 
                        0x00, 0xB8, 0x00, 0x1C
                    })
                    {   // Pin list
                        0x002A,
                        0x002B,
                        0x002C,
                        0x002D,
                        0x002E
                    }
                PinGroup ("pinctrl_fch_xspi", ResourceProducer, ,
                    RawDataBuffer (0x18)  // Vendor Data
                    {
                        0x00, 0xF0, 0x00, 0xDC, 0x00, 0xF4, 0x00, 0xDC, 
                        0x00, 0xF8, 0x00, 0xDC, 0x00, 0xFC, 0x00, 0xDC, 
                        0x01, 0x00, 0x00, 0xDC, 0x01, 0x04, 0x00, 0xDC
                    })
                    {   // Pin list
                        0x003C,
                        0x003D,
                        0x003E,
                        0x003F,
                        0x0040,
                        0x0041
                    }
                PinGroup ("pinctrl_usb0", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xD4, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0035
                    }
                PinGroup ("pinctrl_usb1", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xD8, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0036
                    }
                PinGroup ("pinctrl_usb2", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xDC, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0037
                    }
                PinGroup ("pinctrl_usb3", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xE0, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0038
                    }
                PinGroup ("pinctrl_usb4", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0xCC, 0x00, 0x44, 0x00, 0xE8, 0x00, 0xA4
                    })
                    {   // Pin list
                        0x0033,
                        0x003A
                    }
                PinGroup ("pinctrl_usb5", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0xD0, 0x00, 0x44, 0x00, 0xEC, 0x00, 0xA4
                    })
                    {   // Pin list
                        0x0034,
                        0x003B
                    }
                PinGroup ("pinctrl_usb6", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xBC, 0x00, 0x44
                    })
                    {   // Pin list
                        0x002F
                    }
                PinGroup ("pinctrl_usb7", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xC0, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0030
                    }
                PinGroup ("pinctrl_usb8", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xC4, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0031
                    }
                PinGroup ("pinctrl_usb9", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xC8, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0032
                    }
                PinGroup ("pinctrl_ra8900ce_irq", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0x28, 0x00, 0x44
                    })
                    {   // Pin list
                        0x000A
                    }
                PinGroup ("ssd2_poweren_gpio", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0x20, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0008
                    }
                PinGroup ("ssd1_poweren_gpio", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0x2C, 0x00, 0x44
                    })
                    {   // Pin list
                        0x000B
                    }
                PinGroup ("pinctrl_hog_s5", ResourceProducer, ,
                    RawDataBuffer (0x44)  // Vendor Data
                    {
                        0x00, 0x80, 0x01, 0x44, 0x00, 0x88, 0x01, 0x44, 
                        0x00, 0x24, 0x00, 0x44, 0x00, 0x8C, 0x00, 0x44, 
                        0x00, 0xB4, 0x00, 0xC4, 0x00, 0xA8, 0x00, 0xC4, 
                        0x00, 0x90, 0x00, 0x44, 0x00, 0xB8, 0x00, 0xC4, 
                        0x00, 0xAC, 0x00, 0xC4, 0x00, 0xB0, 0x00, 0xC4, 
                        0x00, 0x94, 0x00, 0x44, 0x00, 0xA0, 0x00, 0x44, 
                        0x00, 0x98, 0x00, 0x44, 0x00, 0xA4, 0x00, 0x44, 
                        0x00, 0x9C, 0x00, 0x44, 0x00, 0x18, 0x00, 0x24, 
                        0x00, 0x84, 0x01, 0x44
                    })
                    {   // Pin list
                        0x0020,
                        0x0022,
                        0x0009,
                        0x0023,
                        0x002D,
                        0x002A,
                        0x0024,
                        0x002E,
                        0x002B,
                        0x002C,
                        0x0025,
                        0x0028,
                        0x0026,
                        0x0029,
                        0x0027,
                        0x0006,
                        0x0021
                    }
            })
        }

        Device (HWMN)
        {
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_HID, "CIXHA024")  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x03)
            }

            Method (SFAT, 0, Serialized)
            {
                \_SB.SPFA ()
            }

            Method (SFMT, 0, Serialized)
            {
                \_SB.SPFM ()
            }

            Method (SFPF, 0, Serialized)
            {
                \_SB.SPFP ()
            }

            Method (SFPW, 3, Serialized)
            {
                Local0 = \_SB.EC0.SFPW (Arg0, Arg1, Arg2)
                Return (Local0)
            }

            Method (GFPW, 2, Serialized)
            {
                Local0 = \_SB.EC0.GFPW (Arg0, Arg1)
                Return (Local0)
            }
        }

        Device (PVC0)
        {
            Name (_HID, "PRP0001")  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "ssd2_poweren_gpio", ResourceConsumer, ,)
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0008
                    }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x08)
                {
                    Package (0x02)
                    {
                        "compatible", 
                        "regulator-fixed"
                    }, 

                    Package (0x02)
                    {
                        "regulator-name", 
                        "ssd2_power"
                    }, 

                    Package (0x02)
                    {
                        "regulator-min-microvolt", 
                        0x00325AA0
                    }, 

                    Package (0x02)
                    {
                        "regulator-max-microvolt", 
                        0x00325AA0
                    }, 

                    Package (0x02)
                    {
                        "gpio", 
                        Package (0x04)
                        {
                            ^PVC0, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "regulator-pull-down", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "enable-active_high", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "off-on-delay-us", 
                        0x3A98
                    }
                }
            })
        }

        Device (PVC1)
        {
            Name (_HID, "PRP0001")  // _HID: Hardware ID
            Name (_UID, 0x08)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "ssd1_poweren_gpio", ResourceConsumer, ,)
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x000B
                    }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x08)
                {
                    Package (0x02)
                    {
                        "compatible", 
                        "regulator-fixed"
                    }, 

                    Package (0x02)
                    {
                        "regulator-name", 
                        "ssd1_power"
                    }, 

                    Package (0x02)
                    {
                        "regulator-min-microvolt", 
                        0x00325AA0
                    }, 

                    Package (0x02)
                    {
                        "regulator-max-microvolt", 
                        0x00325AA0
                    }, 

                    Package (0x02)
                    {
                        "gpio", 
                        Package (0x04)
                        {
                            ^PVC1, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "regulator-pull-down", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "enable-active_high", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "off-on-delay-us", 
                        0x3A98
                    }
                }
            })
        }

        Device (PVC4)
        {
            Name (_HID, "PRP0001")  // _HID: Hardware ID
            Name (_UID, 0x09)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "wifi_vbat_gpio", ResourceConsumer, ,)
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x000C
                    }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x08)
                {
                    Package (0x02)
                    {
                        "compatible", 
                        "regulator-fixed"
                    }, 

                    Package (0x02)
                    {
                        "regulator-name", 
                        "pcie_wifibt_power"
                    }, 

                    Package (0x02)
                    {
                        "regulator-min-microvolt", 
                        0x00325AA0
                    }, 

                    Package (0x02)
                    {
                        "regulator-max-microvolt", 
                        0x00325AA0
                    }, 

                    Package (0x02)
                    {
                        "gpio", 
                        Package (0x04)
                        {
                            ^PVC4, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "regulator-pull-down", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "enable-active_high", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "off-on-delay-us", 
                        0x3A98
                    }
                }
            })
        }

        Device (PVC5)
        {
            Name (_HID, "PRP0001")  // _HID: Hardware ID
            Name (_UID, 0x20)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_hog_s0", ResourceConsumer, ,)
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_hog_s5", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "compatible", 
                        "regulator-fixed"
                    }, 

                    Package (0x02)
                    {
                        "regulator-name", 
                        "gpio-pins"
                    }
                }
            })
        }

        Device (LED1)
        {
            Name (_HID, "PRP0001")  // _HID: Hardware ID
            Name (_UID, 0x21)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "compatible", 
                        "gpio-leds"
                    }
                }
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x001E
                    }
            })
            Device (LDU1)
            {
                Name (_ADR, One)  // _ADR: Address
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "label", 
                            "status-leds"
                        }, 

                        Package (0x02)
                        {
                            "gpios", 
                            Package (0x04)
                            {
                                ^^LED1, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "linux,default-trigger", 
                            "heartbeat"
                        }
                    }
                })
            }
        }

        Device (PKEY)
        {
            Name (_HID, "PRP0001")  // _HID: Hardware ID
            Name (_UID, 0x22)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "compatible", 
                        "gpio-keys"
                    }
                }
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI6", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0001
                    }
            })
            Device (LDU1)
            {
                Name (_ADR, One)  // _ADR: Address
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x04)
                    {
                        Package (0x02)
                        {
                            "label", 
                            "GPIO Power Key"
                        }, 

                        Package (0x02)
                        {
                            "gpios", 
                            Package (0x04)
                            {
                                ^^PKEY, 
                                Zero, 
                                Zero, 
                                One
                            }
                        }, 

                        Package (0x02)
                        {
                            "linux,code", 
                            0x74
                        }, 

                        Package (0x02)
                        {
                            "linux,input-type", 
                            One
                        }
                    }
                })
            }
        }
    }
}

