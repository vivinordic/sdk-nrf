# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "html/kconfig"
  "html/matter"
  "html/mcuboot"
  "html/nrf"
  "html/nrfx"
  "html/nrfxlib"
  "html/tfm"
  "html/zephyr"
  "kconfig"
  "matter"
  "mcuboot"
  "nrf"
  "nrfx"
  "nrfxlib"
  "tfm"
  "zephyr"
  )
endif()
