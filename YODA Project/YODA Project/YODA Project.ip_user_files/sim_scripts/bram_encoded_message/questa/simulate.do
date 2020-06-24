onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib bram_encoded_message_opt

do {wave.do}

view wave
view structure
view signals

do {bram_encoded_message.udo}

run -all

quit -force
