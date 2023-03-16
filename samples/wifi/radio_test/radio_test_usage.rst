.. _wifi_radio_test_usage:

Radio test usage
######################

.. contents::
   :local:
   :depth: 2

Using the Wi-Fi® radio test command ``wifi_radio_test`` and subcommands (See :ref:`wifi_radio_subcommands`).

.. _wifi_radio_test_usage:

Scope
*****

This document gives instructions for loading and running Wi-Fi and Short Range (SR) Radio Test software on the nRF7002 DK/EK

Kit presentation
****************

There are two development kits for nRF7002 – nRF7002DK and nRF7002EK. nRF7002DK is a single board solution while the nRF7002EK is a shield that sits on the Arduino connector of a nRF5340DK. In this document, nRF7002EK refers to the combination of nRF5340DK+nRF7002EK.

.. note::

   Buttons, battery are not used by the software outlined in the document.

DK Top view

EK Top view
TBD 

Setup and Connections
*********************
RF test setup
The following connection is used for performing Wi-Fi and Short Range (SR) RF based tests.

PER test setup
The following connection is used for performing Wi-Fi and Short Range (SR) PER based tests.

Alternatively, the “TX DUT” can be replaced with an appropriate Vector Signal Generator (VSG) if available, e.g. Rohde and Schwarz CMW-500 with appropriate personalities.  
Wi-Fi System level test setup
The following connection is used for performing Wi-Fi association and ping tests with Wi-Fi capable access point.


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

Remaining sub-commands can be called after ``tx_pkt_tput_mode`` sub-command and before TX start.

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
