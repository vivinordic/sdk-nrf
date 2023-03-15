.. _wifi_radio_test_usage:

Radio test usage
######################

.. contents::
   :local:
   :depth: 2

Using the Wi-Fi® radio test command ``wifi_radio_test`` and subcommands (See :ref:`wifi_radio_test_subcmds`).

.. _wifi_radio_test_subcmds:

Wi-Fi radio test subcommands ordering
*************************************
Order of usage of W-Fi radio sub-commands is very important. The ``init`` sub-command must be called first.

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

   uart:~$ wifi_radio_test tx_pkt_tput_mode <Throughput mode>

TX start must be given only after all parameters are configured.

.. code-block:: console

   uart:~$ wifi_radio_test tx 1

.. note::

   While TX transmission is going on further changes in TX parameters are not permitted.

Remaining sub-commands can be called after ``tx_pkt_tput_mode`` sub-command and before TX start.

Wi-Fi radio test examples
***************************

place holder
