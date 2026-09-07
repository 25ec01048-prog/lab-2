# project name
name q10
# execution graph
job 18 -d "1"  -post { extract_vars "$nodedir" n18_des.out 18 }  -o n18_des "sdevice pp18_des.cmd"
job 20 -d "1"  -post { extract_vars "$nodedir" n20_des.out 20 }  -o n20_des "sdevice pp20_des.cmd"
job 30 -d "1"  -post { extract_vars "$nodedir" n30_des.out 30 }  -o n30_des "sdevice pp30_des.cmd"
job 40 -d "1"  -post { extract_vars "$nodedir" n40_des.out 40 }  -o n40_des "sdevice pp40_des.cmd"
job 55 -d "51"  -post { extract_vars "$nodedir" n55_des.out 55 }  -o n55_des "sdevice pp55_des.cmd"
job 59 -d "51"  -post { extract_vars "$nodedir" n59_des.out 59 }  -o n59_des "sdevice pp59_des.cmd"
job 63 -d "51"  -post { extract_vars "$nodedir" n63_des.out 63 }  -o n63_des "sdevice pp63_des.cmd"
job 67 -d "51"  -post { extract_vars "$nodedir" n67_des.out 67 }  -o n67_des "sdevice pp67_des.cmd"
job 79 -d "1"  -post { extract_vars "$nodedir" n79_des.out 79 }  -o n79_des "sdevice pp79_des.cmd"
job 83 -d "51"  -post { extract_vars "$nodedir" n83_des.out 83 }  -o n83_des "sdevice pp83_des.cmd"
job 7 -d "1"  -post { extract_vars "$nodedir" n7_des.out 7 }  -o n7_des "sdevice pp7_des.cmd"
job 56 -d "51"  -post { extract_vars "$nodedir" n56_des.out 56 }  -o n56_des "sdevice pp56_des.cmd"
job 87 -d "1"  -post { extract_vars "$nodedir" n87_des.out 87 }  -o n87_des "sdevice pp87_des.cmd"
job 103 -d "51"  -post { extract_vars "$nodedir" n103_des.out 103 }  -o n103_des "sdevice pp103_des.cmd"
job 119 -d "1"  -post { extract_vars "$nodedir" n119_des.out 119 }  -o n119_des "sdevice pp119_des.cmd"
job 135 -d "51"  -post { extract_vars "$nodedir" n135_des.out 135 }  -o n135_des "sdevice pp135_des.cmd"
job 60 -d "51"  -post { extract_vars "$nodedir" n60_des.out 60 }  -o n60_des "sdevice pp60_des.cmd"
job 57 -d "51"  -post { extract_vars "$nodedir" n57_des.out 57 }  -o n57_des "sdevice pp57_des.cmd"
job 58 -d "51"  -post { extract_vars "$nodedir" n58_des.out 58 }  -o n58_des "sdevice pp58_des.cmd"
job 75 -d "51"  -post { extract_vars "$nodedir" n75_des.out 75 }  -o n75_des "sdevice pp75_des.cmd"
job 3 -d "1"  -post { extract_vars "$nodedir" n3_des.out 3 }  -o n3_des "sdevice pp3_des.cmd"
job 46 -d "1"  -post { extract_vars "$nodedir" n46_des.out 46 }  -o n46_des "sdevice pp46_des.cmd"
job 71 -d "1"  -post { extract_vars "$nodedir" n71_des.out 71 }  -o n71_des "sdevice pp71_des.cmd"
job 44 -d "1"  -post { extract_vars "$nodedir" n44_des.out 44 }  -o n44_des "sdevice pp44_des.cmd"
job 1   -post { extract_vars "$nodedir" n1_dvs.out 1 }  -o n1_dvs "sde -e -l n1_dvs.cmd"
job 53 -d "51"  -post { extract_vars "$nodedir" n53_des.out 53 }  -o n53_des "sdevice pp53_des.cmd"
job 51   -post { extract_vars "$nodedir" n51_dvs.out 51 }  -o n51_dvs "sde -e -l n51_dvs.cmd"
job 31 -d "1"  -post { extract_vars "$nodedir" n31_des.out 31 }  -o n31_des "sdevice pp31_des.cmd"
job 21 -d "1"  -post { extract_vars "$nodedir" n21_des.out 21 }  -o n21_des "sdevice pp21_des.cmd"
job 6 -d "1"  -post { extract_vars "$nodedir" n6_des.out 6 }  -o n6_des "sdevice pp6_des.cmd"
job 8 -d "1"  -post { extract_vars "$nodedir" n8_des.out 8 }  -o n8_des "sdevice pp8_des.cmd"
job 10 -d "1"  -post { extract_vars "$nodedir" n10_des.out 10 }  -o n10_des "sdevice pp10_des.cmd"
job 12 -d "1"  -post { extract_vars "$nodedir" n12_des.out 12 }  -o n12_des "sdevice pp12_des.cmd"
job 9 -d "1"  -post { extract_vars "$nodedir" n9_des.out 9 }  -o n9_des "sdevice pp9_des.cmd"
job 5 -d "1"  -post { extract_vars "$nodedir" n5_des.out 5 }  -o n5_des "sdevice pp5_des.cmd"
job 4 -d "1"  -post { extract_vars "$nodedir" n4_des.out 4 }  -o n4_des "sdevice pp4_des.cmd"
job 14 -d "1"  -post { extract_vars "$nodedir" n14_des.out 14 }  -o n14_des "sdevice pp14_des.cmd"
check mosfet_1_dvs.cmd 1788504833
check mosfet_1_dvs.bnd 1788503542
check Breakdown_des.cmd 1788503542
check sdevice.par 1788503542
check id_vds_des.cmd 1788758212
check idvg_des.cmd 1788758198
check equillibrium_des.cmd 1788503542
check idon_des.cmd 1788507460
check idoff_des.cmd 1788505083
check global_tooldb 1697803711
check gtree.dat 1788758048
check ./Nitride.par 1788503542
check ./PolySilicon.par 1788503542
check ./SiO2.par 1788503542
check ./Silicide.par 1788503542
check ./Silicon.par 1788503542
# included files
file sdevice.par included ./Nitride.par
file sdevice.par included ./PolySilicon.par
file sdevice.par included ./SiO2.par
file sdevice.par included ./Silicide.par
file sdevice.par included ./Silicon.par
