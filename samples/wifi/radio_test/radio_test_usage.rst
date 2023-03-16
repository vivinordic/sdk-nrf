.. _wifi_radio_test_usage:

Radio test usage
######################

.. contents::
   :local:
   :depth: 2

.. _wifi_radio_test_usage:

Scope
*****

This document gives instructions for loading and running Wi-Fi and Short Range (SR) Radio Test software on the nRF7002 DK/EK

Kit presentation
****************

There are two development kits for nRF7002 – nRF7002DK and nRF7002EK. nRF7002DK is a single board solution while the nRF7002EK is a shield that sits on the Arduino connector of a nRF5340DK. In this document, nRF7002EK refers to the combination of nRF5340DK+nRF7002EK.

.. note::

   Buttons, battery are not used by the software outlined in the document.

DK Top view:

  .. figure:: /images/wifi_coex_ble.png
       :width: 780px
       :align: center
       :alt: DK Top view

       DK Top view

EK Top view:

  .. figure:: /images/wifi_coex_ble.png
       :width: 780px
       :align: center
       :alt: EK Top view

       EK Top view

Setup and Connections
*********************
RF test setup:
   The following connection is used for performing Wi-Fi and Short Range (SR) RF based tests.

   .. figure:: /images/wifi_coex_ble.png
        :width: 780px
        :align: center
        :alt: RF test setup

        RF test setup

PER test setup:
   The following connection is used for performing Wi-Fi and Short Range (SR) PER based tests.

   .. figure:: /images/wifi_coex_ble.png
        :width: 780px
        :align: center
        :alt: PER test setup

        PER test setup

   Alternatively, the “TX DUT” can be replaced with an appropriate Vector Signal Generator (VSG) if available, e.g. Rohde and Schwarz CMW-500 with appropriate personalities.  
   Wi-Fi System level test setup
   The following connection is used for performing Wi-Fi association and ping tests with Wi-Fi capable access point.

Wi-Fi System level test setup:
   The following connection is used for performing Wi-Fi association and ping tests with Wi-Fi capable access point.

   .. figure:: /images/wifi_coex_ble.png
        :width: 780px
        :align: center
        :alt: Wi-Fi System level test setup

        Wi-Fi System level test setup

Firmware for tests, description and list of files
*************************************************
nRF7002 firmware can be built as multiple samples – Radio Test and Wi-Fi Radio Test, Wi-Fi Station and Wi-Fi Shell.
The nRF7002 comprises an nRF5340 SR device and an nRF7002 Wi-Fi device.
The nRF5340 device contains two cores, an Application (APP) core and a Network (NET) core.
Radio Test executes directly on the NET core, while Wi-Fi Radio Test,
Station and Shell samples execute on the APP core and communicates with the nRF7002 slave device.

The combined build of Radio Test and Wi-Fi Radio Test firmware:

  Short Range Radio test description:
  
     * Wi-Fi Radio test description - :ref:`wifi_radio_sample_desc`
     * Radio Test controls the Short Range (SR) radio, while Wi-Fi Radio Test controls the Wi-Fi radio.
     * Allows to put the DUT in all needed Transmission / Reception modes to perform RF emissions tests both in Wi-Fi and Short Range Radio.
     * Allows to do all Bluetooth/Thread tests as required for EMI/EMC testing.
     * Allows to do all Wi-Fi tests as required for EMI/EMC testing.

  Wi-Fi Station sample:

     * Detailed description - :ref:`wifi_radio_sample_desc`
     * Allows DUT to connect to a Wi-Fi Access Point device and gives visual indication of connected state (LED1 blinking) or not (LED1 off)
     * Allows an option to statically set a desired IP address to the DUT at build time via settings in prj.conf file.
       This IP address will be used by the device up on connection to Access Point in case DHCP resolution fails for any reason.

  Wi-Fi Shell sample:

     * Detailed description - :ref:`wifi_radio_sample_desc`
     * Allows DUT to connect to an Wi-Fi Access Point device and expose a shell interface via the UART console to run relevant Wi-Fi shell commands .
     * Allows an option to statically set a desired IP address to the DUT at build time via settings in prj.conf file.
     This IP address will be used by the device up on connection to Access Point in case DHCP resolution fails for any reason.

Build instructions:

* Standalone Wi-Fi Radio Test: <ncs_repo>/ncs/nrf/samples/wifi/radio_test

  .. code-block:: console

     $ west build -p -b nrf7002dk_nrf5340_cpuapp (DK Build)
     $ west build -p -b nrf5340dk_nrf5340_cpuapp -- -DSHIELD=nrf7002_ek (EK build)

  Hex file generated – build/zephyr/zephyr.hex

* Radio Test and Wi-Fi Radio Test combined build: <ncs_repo>/ncs/nrf/samples/wifi/radio_test

  set CONFIG_BOARD_ENABLE_CPUNET=y in <ncs_repo>/nrf/samples/wifi/radio/test/prj.conf
  set CONFIG_NCS_SAMPLE_REMOTE_SHELL_CHILD_IMAGE=n in <ncs_repo>/nrf/samples/peripheral/radio_test/prj_nrf5340dk_nrf5340_cpunet.conf

  .. code-block:: console

     $ west build -p -b nrf7002dk_nrf5340_cpuapp  (DK build)
     $ west build -p -b nrf5340dk_nrf5340_cpuapp -- -DSHIELD=nrf7002_ek (EK build)

  Hex files generated –

  * Combined hex file : build/zephyr/merged_domains.hex
  * APP core hex file: build/zephyr/merged.hex
  * NET core hex file: build/peripheral_radio_test/zephyr/merged_CPUNET.hex

* Wi-Fi Station build : <ncs_repo>/ncs/nrf/samples/wifi/sta
  Change the CONFIG parameters in Prj.conf as per Access Point requirements -
  * Credentials - CONFIG_STA_KEY_MGMT_*, CONFIG_STA_SAMPLE_SSID, CONFIG_STA_SAMPLE_PASSWORD
  * Static IP address - CONFIG_NET_CONFIG_MY_IPV4_ADDR, CONFIG_NET_CONFIG_MY_IPV4_NETMASK, CONFIG_NET_CONFIG_MY_IPV4_GW
    (These are only used if IP address is not acquired due to DHCP failure)

  .. code-block:: console

     $ west build -p -b nrf7002dk_nrf5340_cpuapp  (DK build)
     $ west build -p -b nrf5340dk_nrf5340_cpuapp -- -DSHIELD=nrf7002_ek (EK build)

  Hex file generated – build/zephyr/zephyr.hex
* Wi-Fi Shell build : <ncs_repo>/ncs/nrf/samples/wifi/shell

  .. code-block:: console

     $ west build -p -b nrf7002dk_nrf5340_cpuapp  (DK build)
     $ west build -p -b nrf5340dk_nrf5340_cpuapp -- -DSHIELD=nrf7002_ek (EK build)

Firmware files:

* Applications Core
  nrf_cefcc_combo_rf_test_APP_<ncs_version>.nrf7002_dk_RevB.hex

* Network Core
  nrf_cefcc_combo_rf_test_NET_<ncs_version>.nrf7002_dk_RevB.hex

How to program Firmware in nRF7002 Setup
****************************************

* Have nRFJPROG tool installed on PC. This program can be downloaded at

https://www.nordicsemi.com/Products/Development-tools/nRF-Command-Line-Tools/Download?lang=en#infotabs

* Connect PC to nRF7002 board with USB cable.
* Switch nRF7002 board on.

Program Radio Test Firmware:
  * Program nrf_cefcc_combo_rf_test_APP_v3.nrf7002_dk_RevB.hex to application core on nRF7002- DK/EK

  .. code-block:: console

     $ nrfjprog --program nrf_cefcc_combo_rf_test_APP_v3.nrf7002_dk_RevB.hex -f NRF53 --coprocessor CP_APPLICATION --verify --chiperase --reset

  * Program nrf_cefcc_combo_rf_test_NET_v3.nrf7002_dk_RevB.hex to network core on nRF7002- DK/EK

  .. code-block:: console

     $ nrfjprog --program nrf_cefcc_combo_rf_test_NET_v3.nrf7002_dk_RevB.hex -f NRF53 --coprocessor CP_NETWORK --verify --chiperase --reset

  * Reset the nRF7002- DK/EK to start it running firmware

    Press reset button, or
    Invoke reset command in nRFJPROG, or
    Power cycle the devkit

  .. note::

     Baud rate shall be set to 115200bps. Details about COM port setup at the end of this document.

Wi-Fi radio test subcommands ordering
*************************************
Order of usage of Wi-Fi radio test sub-commands is very important. The ``init`` sub-command must be called first.

.. code-block:: console

   uart:~$ wifi_radio_test init <channel number>

.. note::

   The ``init`` sub-command disables any ongoing TX or RX testing and sets all configured parameters to default.

The second sub-command to call is ``tx_pkt_tput_mode``.

.. code-block:: console

   uart:~$ wifi_radio_test tx_pkt_tput_mode <Throughput mode>

.. note::

   The ``tx_pkt_tput_mode`` sub-command is used to set frame format of the transmitted packet.

For HETB packets (tx_pkt_tput_mode 5), ``ru_tone`` sub-command must be called before ``ru_index`` sub-command.
And ``ru_index`` sub-command must be called before ``tx_pkt_len`` sub-command.

.. code-block:: console

   uart:~$ wifi_radio_test ru_tone 106
   uart:~$ wifi_radio_test ru_index 2
   uart:~$ wifi_radio_test tx_pkt_len 1024


TX start must be given only after all parameters are configured.

.. code-block:: console

   uart:~$ wifi_radio_test tx 1

.. note::

   While TX transmission is going on further changes in TX parameters are not permitted.

Remaining sub-commands can be called in any order after ``tx_pkt_tput_mode`` sub-command and before TX start.

Wi-Fi radio test examples
***************************

#. To run a continuous (DSSS/CCK) TX sequence in 802.11b mode:
    - Channel: 1
    - Payload length: 1024 bytes
    - Inter-frame gap: 8600 us
    - datarate: 1Mbps
    - Long Preamble: 1
    - TX power: 20 dBm

    Execute the following sequence of commands:

      .. code-block:: console

         uart:~$ wifi_radio_test init 1
         uart:~$ wifi_radio_test tx_pkt_tput_mode 0
         uart:~$ wifi_radio_test tx_pkt_preamble 1
         uart:~$ wifi_radio_test tx_pkt_rate 1
         uart:~$ wifi_radio_test tx_pkt_len 1024
         uart:~$ wifi_radio_test tx_pkt_gap 8600
         uart:~$ wifi_radio_test tx_power 20
         uart:~$ wifi_radio_test tx_pkt_num -1
         uart:~$ wifi_radio_test tx 1

    .. note::

       Frame duration with above config = 8624 us, duty-cycle achieved = 50.07%
#. To run a continuous (OFDM) TX traffic sequence in 11g mode:
    - Channel: 11
    - Payload length 4000 bytes
    - Inter-frame gap: 200 us
    - data rate : 6Mbps
    - TX power : 0 dBm

    Execute the following sequence of commands:

      .. code-block:: console

         uart:~$ wifi_radio_test init 11
         uart:~$ wifi_radio_test tx_pkt_tput_mode 0
         uart:~$ wifi_radio_test tx_pkt_rate 6
         uart:~$ wifi_radio_test tx_pkt_len 4000
         uart:~$ wifi_radio_test tx_pkt_gap 200
         uart:~$ wifi_radio_test tx_power 0
         uart:~$ wifi_radio_test tx_pkt_num -1
         uart:~$ wifi_radio_test tx 1

    .. note::

       Frame duration with above config = 5400 us, duty-cycle achieved = 96.4%

#. To run a continuous (OFDM) TX traffic sequence in 11a mode:
    - Channel: 40
    - Payload length 4000 bytes
    - Inter-frame gap: 200 us
    - data rate : 54Mbps
    - TX power : 10 dBm

    Execute the following sequence of commands:

      .. code-block:: console

         uart:~$ wifi_radio_test init 40
         uart:~$ wifi_radio_test tx_pkt_tput_mode 0
         uart:~$ wifi_radio_test tx_pkt_rate 54
         uart:~$ wifi_radio_test tx_pkt_len 4000
         uart:~$ wifi_radio_test tx_pkt_gap 200
         uart:~$ wifi_radio_test tx_power 10
         uart:~$ wifi_radio_test tx_pkt_num -1
         uart:~$ wifi_radio_test tx 1

    .. note::

       Frame duration with above config = 620 us, duty-cycle achieved = 75.6%

#. To run a continuous (OFDM) TX traffic sequence in HT (11n) mode:
    - Channel: 11
    - Frame format: HT (11n)
    - Payload len: 4000 bytes
    - Inter-frame gap: 200 us
    - data rate : MCS7
    - Long Guard
          - TX power :  0 dBm

    Execute the following sequence of commands:

      .. code-block:: console

         uart:~$ wifi_radio_test init 11
         uart:~$ wifi_radio_test tx_pkt_tput_mode 1
         uart:~$ wifi_radio_test tx_pkt_preamble 2
         uart:~$ wifi_radio_test tx_pkt_mcs 7
         uart:~$ wifi_radio_test tx_pkt_len 4000
         uart:~$ wifi_radio_test tx_pkt_sgi 0
         uart:~$ wifi_radio_test tx_pkt_gap 200
         uart:~$ wifi_radio_test tx_power 0
         uart:~$ wifi_radio_test tx_pkt_num -1
         uart:~$ wifi_radio_test tx 1

    .. note::

       Frame duration with above config = 536 us, duty-cycle achieved = 72.8%

#. To run a continuous (OFDM) TX traffic sequence in VHT (11ac) mode:
    - Channel: 40
    - Frame format: VHT (11ac)
    - Payload len: 4000 bytes
    - Inter-frame gap: 200 us
    - data rate : MCS7
    - Long Guard
    - TX power :  0 dBm

    Execute the following sequence of commands:

      .. code-block:: console

         uart:~$ wifi_radio_test init 40
         uart:~$ wifi_radio_test tx_pkt_tput_mode 2
         uart:~$ wifi_radio_test tx_pkt_mcs 7
         uart:~$ wifi_radio_test tx_pkt_len 4000
         uart:~$ wifi_radio_test tx_pkt_sgi 0
         uart:~$ wifi_radio_test tx_pkt_gap 200
         uart:~$ wifi_radio_test tx_power 0
         uart:~$ wifi_radio_test tx_pkt_num -1
         uart:~$ wifi_radio_test tx 1

    .. note::

       Frame duration with above config = 540 us, duty-cycle achieved = 73%

#. To run a continuous (OFDM) TX traffic sequence in HE-SU (11ax) mode:
    - Channel: 116
    - Frame format: HESU (11ax)
    - Payload len: 4000
    - Inter-frame gap: 200 us
    - data rate : MCS7
    - 3.2us GI
    - 4x HELTF
    - TX power :  0 dBm

    Execute the following sequence of commands:

      .. code-block:: console

         uart:~$ wifi_radio_test init 116
         uart:~$ wifi_radio_test tx_pkt_tput_mode 3
         uart:~$ wifi_radio_test tx_pkt_mcs 7
         uart:~$ wifi_radio_test tx_pkt_len 4000
         uart:~$ wifi_radio_test he_ltf 2
         uart:~$ wifi_radio_test he_gi 2
         uart:~$ wifi_radio_test tx_pkt_gap 200
         uart:~$ wifi_radio_test tx_power 0
         uart:~$ wifi_radio_test tx_pkt_num -1
         uart:~$ wifi_radio_test tx 1

    .. note::

       Frame duration with above config = 488 us, duty-cycle achieved = 70.9%

#. To run a continuous (OFDM) TX traffic sequence in HE-ER-SU (11ax) mode:
    - Channel: 100
    - Frame format: HE-ERSU (11ax)
    - Payload len: 1000
    - Inter-frame gap: 200 us
    - data rate : MCS0
    - 3.2us GI
    - 4x HELTF
    - TX power: 10dBm
    Execute the following sequence of commands:

      .. code-block:: console

         uart:~$ wifi_radio_test init 100
         uart:~$ wifi_radio_test tx_pkt_tput_mode 4
         uart:~$ wifi_radio_test tx_pkt_mcs 0
         uart:~$ wifi_radio_test tx_pkt_len 1000
         uart:~$ wifi_radio_test he_ltf 2
         uart:~$ wifi_radio_test he_gi 2
         uart:~$ wifi_radio_test tx_pkt_gap 200
         uart:~$ wifi_radio_test tx_power 10
         uart:~$ wifi_radio_test tx_pkt_num -1
         uart:~$ wifi_radio_test tx 1

    .. note::

       Frame duration with above config = 1184 us, duty-cycle achieved = 85.5%

#. To run a continuous (OFDM) TX traffic sequence in HE-TB-PPDU (11ax) mode:
    - Channel: 100
    - Frame format: HE-TB (11ax)
    - Payload len: 1024
    - Inter-frame gap: 200 us
    - data rate : MCS7
    - 3.2us GI
    - 106 Tone
    - 4x HELTF
    - RU Index 2
    - TX power: 10dBm
    Execute the following sequence of commands:

      .. code-block:: console

         uart:~$ wifi_radio_test init 100
         uart:~$ wifi_radio_test tx_pkt_tput_mode 5
         uart:~$ wifi_radio_test ru_tone 106
         uart:~$ wifi_radio_test ru_index 2
         uart:~$ wifi_radio_test tx_pkt_len 1024
         uart:~$ wifi_radio_test tx_pkt_mcs 7
         uart:~$ wifi_radio_test he_ltf 2
         uart:~$ wifi_radio_test he_gi 2
         uart:~$ wifi_radio_test tx_pkt_gap 200
         uart:~$ wifi_radio_test tx_power 10
         uart:~$ wifi_radio_test tx_pkt_num -1
         uart:~$ wifi_radio_test tx 1

    .. note::

       Frame duration with above config = 332us, duty-cycle achieved = 62.4%
