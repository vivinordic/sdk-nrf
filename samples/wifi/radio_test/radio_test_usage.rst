.. _wifi_radio_test_usage:

Radio test usage
######################

.. contents::
   :local:
   :depth: 2

Using the Wi-Fi® radio test command ``wifi_radio_test`` and subcommands (See :ref:`wifi_radio_subcommands`).

.. _wifi_radio_test_usage:

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
