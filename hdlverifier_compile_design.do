# Create design library
vlib work
vmap altera_mf C:/Users/h92j874/Desktop/Lab4/simlib/vhdl_libs/altera_mf

# Create and open project
project new . compile_project
project open compile_project
# Add source files to project
project addfile "C:/Users/h92j874/Desktop/Lab4/Lab4_SQRT_TOP.vhd"
project addfile "C:/Users/h92j874/Desktop/Lab4/lzc.vhd"
project addfile "C:/Users/h92j874/Desktop/Lab4/Newton.vhd"
project addfile "C:/Users/h92j874/Desktop/Lab4/ROM.vhd"
project addfile "C:/Users/h92j874/Desktop/Lab4/Y0.vhd"
# Calculate compilation order
project calculateorder
set compcmd [project compileall -n]
# Close project
project close
# Compile all files and report error
if [catch {eval $compcmd}] {
    exit -code 1
}
