onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib bram_decoded_message_opt

do {wave.do}

view wave
view structure
view signals

do {bram_decoded_message.udo}

run -all

quit -force
