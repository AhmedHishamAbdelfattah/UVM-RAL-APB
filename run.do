vlib work
vlog -f files_new.txt  +cover
vsim -voptargs=+acc work.tb_new -cover
run 0
do wave.do
run -all 