less log.err
#1734387257
less log.
#1734387260
less log.out
#1734387329
less job.script 
#1734387346
nano job.script 
#1734387371
qsub job.script 
#1734387376
qstat
#1734387390
ls
#1734387394
qstat
#1734387434
ls
#1734387437
less log.
#1734387440
less log.out 
#1734387449
rm log.err
#1734387450
ls
#1734387456
less log.out
#1734387472
nano job.script 
#1734387568
qsub job.script 
#1734387607
ls
#1734387635
less hpc_24a_ex01.out 
#1734387651
pwd[A
#1734387668
nano job.script 
#1734387735
qsub job.script 
#1734387784
qstat
#1734387787
ls
#1734387798
less hpc_24a_ex01.out 
#1734388321
qsub -I
#1734388423
qsub -I -q entry_teachingq
#1734389226
cd /home/rn14pyry/pbs.846289.mmaster02.x8z
#1734389374
cd ..
#1734389375
ls
#1734389382
cd HPC_CMS_202425/
#1734389384
ls
#1734389390
hello-openmp
#1734389406
export OMP_NUM_THREADS=4
#1734389417
time ./hello-openmp 
#1734389427
exit
#1734388989
ls
#1734388999
cd HPC_CMS_202425/
#1734389001
ls
#1734389069
echo -e "Create your C++ file"
#1734389093
nano mpi_hpc24a_2.C 
#1734389124
g++ -o hello-openmp mpi_hpc24a_2.C -O0 -fopenmp
#1734389160
echo -e "Create executable, here hello-openmp"
#1734389184
qsub -I -q entry_teachingq
#1734389446
history >> hpc_24a_ex01.hist
#1734389448
ls
#1734389457
less hpc_24a_ex01.hist 
#1734472668
cd /home/rn14pyry/pbs.846563.mmaster02.x8z
#1734472715
mpirun -np 2 ./PVL2.out
#1734472782
mpiexec PVL2.out
#1734472798
cd ..
#1734472799
ls
#1734472802
cd PVL_202425/
#1734472803
ls
#1734472811
mpirun -np 2 ./PVL2.out
#1734472822
mpiexec -np 2 ./PVL2.out
#1734472913
mpiexec -n 2 ./PVL2.out
#1734473097
exit
#1734473151
cd /home/rn14pyry/pbs.846564.mmaster02.x8z
#1734473193
mpiexec -n 2 ./PVL2.out
#1734473267
exit
#1734473545
cd /home/rn14pyry/pbs.846565.mmaster02.x8z
#1734473591
cd ..
#1734473592
ls
#1734473595
cd PVL_202425/
#1734473596
ls
#1734473602
mpiexec -n 2 ./PVL2.out
#1734473752
mpiexec --oversubscribe -n 2 ./PVL2.out
#1734473836
exit
#1734473926
cd /home/rn14pyry/pbs.846566.mmaster02.x8z
#1734473934
mpiexec --oversubscribe -n 2 ./PVL2.out
#1734474094
mpiexec --oversubscribe -n 2 ./PVL2
#1734474108
mpiexec -np 2 ./PVL2
#1734474120
mpiexec --oversubscribe -n 2 ./PVL2
#1734474224
mpiexec --oversubscribe -n 2 ./PVL2.out
#1734474231
exit
#1734474746
cd /home/rn14pyry/pbs.846567.mmaster02.x8z
#1734474750
cd ..
#1734474818
ls
#1734474820
cd PVL_202425/
#1734474828
mpiexec --oversubscribe -n 2 ./PVL2.out
#1734474848
mpiexec --oversubscribe -n 2 ./PVL2
#1734474861
mpiexec -n 2 ./PVL2
#1734474865
mpiexec --oversubscribe -n 2 ./PVL2
#1734475052
exit
#1734475127
cd /home/rn14pyry/pbs.846568.mmaster02.x8z
#1734475131
cd ..
#1734475132
ls
#1734475134
cd PVL_202425/
#1734475135
ls
#1734475142
mpiexec --oversubscribe -n 2 ./PVL2
#1734475161
mpiexec -n 2 ./PVL2
#1734475197
mpiexec --oversubscribe -n 2 ./PVL2
#1734475832
exit
#1734468706
ls
#1734468715
cd HPC_CMS_202425
#1734468795
ls
#1734468803
cd ..
#1734468812
]mkdir PVL_202425
#1734468838
ls
#1734468852
mkdir PVL_202425
#1734468857
ls
#1734468863
cd PVL_202425
#1734469831
nano PVL2.C
#1734471993
mpic++ -o PVL2.out PVL.C
#1734472010
mpiCC -o PVL2.out PVL.C
#1734472044
mpicc -o PVL2.out PVL.C
#1734472119
module available
#1734472215
module load openmpi/gcc/11.4.0
#1734472228
mpicc -o PVL2.out PVL.C
#1734472235
mpicc -o PVL2.out PVL2.C
#1734472287
nano PVL2.C
#1734472381
mpicc -o PVL2.out PVL2.C
#1734472481
nano PVL2.C
#1734472507
mpicc -o PVL2.out PVL2.C
#1734472510
ls
#1734472626
qsub -I -q entry_teachingq
#1734473099
ls
#1734473109
qsub -I -q teachingq
#1734473274
less PVL2.C
#1734473335
nano PVL2.C
#1734473489
mpicc -o PVL2 PVL2.C
#1734473492
ls
#1734473503
qsub -I -q teachingq
#1734473838
ls
#1734473844
nano PVL2.C
#1734473879
mpicc -o PVL2 PVL2.C
#1734473884
qsub -I -q teachingq
#1734474321
ls
#1734474332
nano PVL2.C
#1734474398
mpicc -o PVL2 PVL2.C
#1734474446
mpiexec -n 2 PVL2
#1734474704
qsub -I -q teachingq
#1734475055
l
#1734475056
ls
#1734475062
nano PVL2.C
#1734475080
mpicc -o PVL2 PVL2.C
#1734475085
qsub -I -q teachingq
#1734475835
exit
#1734548206
cd /home/rn14pyry/pbs.846754.mmaster02.x8z
#1734548222
cd ..
#1734548223
ls
#1734548227
cd PVL_202425/
#1734548228
ls
#1734548236
mpiexec -n 2 PVL2
#1734548267
module load openmpi/gcc/11.4.0
#1734548271
mpiexec -n 2 PVL2
#1734548613
mpiexec -n 2 ./PVL2
#1734548776
ls
#1734548779
cd ..
#1734548780
ls
#1734548789
cd HPC_CMS_202425/
#1734548790
ls
#1734548799
less job.script
#1734548808
exit
#1734549033
cd /home/rn14pyry/pbs.846757.mmaster02.x8z
#1734549051
module load openmpi/gcc/11.4.0
#1734549059
ls
#1734549062
cd ..
#1734549063
ls
#1734549065
cd PVL_202425/
#1734549066
ls
#1734549070
cd ..
#1734549078
cd HPC_CMS_202425/
#1734549078
ls
#1734549094
qsub job.script
#1734549104
ls
#1734549108
qstat
#1734549221
ls
#1734549224
qstat
#1734549230
less log.out 
#1734549277
cp job.script ../PVL_202425/
#1734549280
cd ..
#1734549281
ls
#1734549285
cd PVL_202425/
#1734549286
ls
#1734549291
nano job.script
#1734549298
exit
#1734549443
cd /home/rn14pyry/pbs.846760.mmaster02.x8z
#1734549479
qsub job.script
#1734549493
module load openmpi/gcc/11.4.0
#1734549555
qsub job.script
#1734549653
cd ..
#1734549656
ls
#1734549659
cd PVL_202425/
#1734549659
ls
#1734549663
qsub job.script
#1734549666
qstat
#1734549803
ls
#1734549812
less PVL2.out
#1734549821
exit
#1734552525
cd /home/rn14pyry/pbs.846779.mmaster02.x8z
#1734552529
ls
#1734552533
cd ..
#1734552535
ls
#1734552544
cd ~
#1734552545
ls
#1734552554
cd PVL_202425
#1734552559
ls
#1734552576
less job.script
#1734552579
pwd
#1734552592
exit
#1734552766
cd /home/rn14pyry/pbs.846781.mmaster02.x8z
#1734552770
ls
#1734552773
cd ..
#1734552777
cd PVL_202425
#1734552778
ls
#1734552787
mpiexec -n 2 PVL2_2
#1734552802
mpiexec -oversubscribe -n 2 PVL2_2
#1734552824
exit
#1734553779
ls
#1734553788
qsub -I -q teachingq
#1734553830
cd /home/rn14pyry/pbs.846790.mmaster02.x8z
#1734553841
ls
#1734553846
cd ~
#1734553849
ls
#1734553892
mpiexec -n 2 PVL2_2
#1734553903
module load openmpi/gcc/11.4.0
#1734553906
mpiexec -n 2 PVL2_2
#1734553945
pqd
#1734553949
pwd
#1734553952
ls
#1734554054
cd ~
#1734554055
ls
#1734556122
cd PVL_202425
#1734556123
ls
#1734556130
qsub job.script
#1734556135
qstat
#1734556189
ls
#1734556191
qstat
#1734556199
less PVL2_output.out
#1734556207
less PVL2_output.err
#1734556238
ls
#1734556242
clear
#1734556243
ls
#1734556277
nano job.script
#1734556354
qsub job.script
#1734556357
qstat
#1734556399

#1734556473
qstat
#1734556551
less PVL_output.out
#1734556557
less PVL2_output.out
#1734556569
less PVL2_output.err
#1734556585
nano job.script
#1734556636
qsub job.script
#1734556661
qstat
#1734557042
less PVL2_output.out
#1734557067
less PVL2_output.err
#1734557309
nano job.script
#1734557339
mpiexec -n 2 PVL2_3
#1734557358
module load openmpi/gcc/11.4.0
#1734557362
mpiexec -n 2 PVL2_3
#1734557375
nano job.script
#1734557402
qsub job.script
#1734557410
qstat
#1734557425
less job.script
#1734557564
qstat
#1734557572
less PVL2_output.out
#1734557579
nano job.script
#1734557618
qsub job.script
#1734557655
qstat
#1734557711
less PVL2_output.out
#1734557727
less PVL2_output.err
#1734557778
less PVL2.C
#1734557801
nano PVL2.C
#1734557842
less PVL2.C
#1734557973
less job.script
#1734558010
ls
#1734558016
rm PVL2_2
#1734558019
rm PVL2
#1734558025
rm hpc_24a_ex01.out
#1734558034
rm hpc_24a_ex01.err 
#1734558035
ls
#1734558051
qsub job.script
#1734558056
qstat
#1734558245
less PVL2_output.out
#1734558256
less PVL2_output.err
#1734558414
ls -l
#1734558505
less PVL2_output.out
#1734558915
ls
#1734558929
rm PVL2.out
#1734558930
ls
#1734558949
less PVL2_output.out
#1734558957
exit
#1734548140
ls
#1734548144
cd PVL_202425/
#1734548144
ls
#1734548164
qsub -I -q teachingq
#1734548930
qsub job.script
#1734548947
ls
#1734548986
qstat
#1734548991
qsub -I -q teachingq
#1734549301
ls
#1734549314
nano job.script
#1734549401
qsub -I -q teachingq
#1734549831
less PVL2.out
#1734549859
ls
#1734549872
less hpc_24a_ex01.
#1734549875
less hpc_24a_ex01.out 
#1734549894
mpiexec -n 2 PVL2
#1734549923
less PVL2.C
#1734549935
nano PVL2.C
#1734550043
cp PVL2.C PVL2.cpp
#1734550045
ls
#1734550065
mpicpp -o PVL2_2 PVL2.cpp
#1734550083
mpicc -o PVL2_2 PVL2.cpp
#1734550153
mpicc -o PVL2 PVL2.pp
#1734550426
module load mpich/gcc
#1734550443
module available
#1734550531
module --default avaik
#1734550536
module --default avail
#1734550582
module load mpich
#1734550601
cd ..
#1734550607
module load mpich/gcc
#1734550655
module load mpicc/gcc
#1734550698
l
#1734550700
ls
#1734550706
cd HPC_CMS
#1734550707
ls
#1734550714
less mpi_first.C 
#1734550724
cd ..
#1734550732
cd HPC_CMS_Home
#1734550734
ls
#1734550748
less mpi_hpc23c_3.C
#1734550761
cd ..
#1734550767
ls
#1734550769
cd PVL_202425/
#1734550774
ls
#1734550791
less PVL2.C
#1734550798
nano PVL2.C
#1734550872
mpicc PVL2.C PVL2_2.out  
#1734550884
mpiCC PVL2.C PVL2_2.out  
#1734550927
module load openmpi/gcc/11.4.0
#1734550935
mpicc PVL2.C PVL2_2.out  
#1734550960
mpicc PVL2.C -i PVL2_2.out  
#1734550977
mpicc --help
#1734551018
mpicc -o PVL2.C PVL2.out
#1734551028
clear
#1734551029
ls
#1734551042
nano PVL2.cpp
#1734551053
mpicc -o PVL2.cpp PVL2.out
#1734551069
mpicc -o PVL2.cpp PVL2_2
#1734551098
mpicc -o PVL2_2 PVL2.cpp
#1734551101
ls
#1734551116
ls -l
#1734551120
cd ..
#1734551120
ls
#1734551125
cd PVL_202425
#1734551127
ls
#1734551322
nano PVL2.C
#1734551346
mpicc -o PVL2_2 PVL2.C
#1734551347
ls
#1734551355
nano job.script
#1734551477
qsub job.script
#1734551495
qstat
#1734551498
ls
#1734551507
qstat
#1734551526
less job.script 
#1734551537
ls
#1734551546
qstat
#1734551547
ls
#1734551559
nano job.script
#1734551617
ls
#1734551629
qsub job.script
#1734551632
qstat
#1734551687
ls
#1734551693
cd ..
#1734551694
ls
#1734551705
cd HPC_CMS_202425/
#1734551706
ls
#1734551715
cd ..
#1734551717
ls 
#1734551721
cd PVL_202425/
#1734551723
ls
#1734551733
less job.script
#1734551834
nano job.script
#1734551866
qsub job.script
#1734551873
less hpc_24a_ex01.out
#1734551882
less hpc_24a_ex01.err
#1734551908
qstat
#1734551915
mpiexec -n 2 PVL2_2
#1734552063
qstat
#1734552064
ls
#1734552072
less PVL2_output.out 
#1734552097
nano job.script
#1734552115
mpiexec -n 2 PVL2_2
#1734552141
qsub job.script
#1734552350
qstat
#1734552353
ls
#1734552362
less PVL2_output.out 
#1734552382
nano job.script
#1734552442
qsub -I -q teachinq
#1734552445
qsub -I -q teachingq
#1734552595
pwd
#1734552604
nano job.script
#1734552629
qsub job.script
#1734552636
qstat
#1734552700
ls
#1734552706
less PVL2_output.out
#1734552725
qsub -I -q teachingq
#1734552825
ls
#1734552830
less PVL2_2
#1734552839
less PVL2.C
#1734553006
nano PVL2.C
#1734553077
mpicc -o PVL2_3 PVL2.C
#1734553085
mpiexec -n 2 PVL2_3
#1734553153
less PVL2_output.err
#1734553184
nano job.script
#1734553249
qsub job.script
#1734553252
qstat
#1734553302
ls
#1734553306
qstat
#1734553350
ls
#1734553358
less PVL2_output.out
#1734553369
less PVL2_output.err
#1734553470
less job.script
#1734553502
nano job.script
#1734553567
qsub job.script
#1734553641
qstat
#1734553643
ls
#1734553653
less PVL2_output.out
#1734553689
nano job.script
#1734553708
cp PVL2_2 ~/
#1734553709
ls
#1734553710
cd ..
#1734553711
ls
#1734553718
cd PVL_202425/
#1734553725
qsub job.script
#1734553740
qstat
#1734553795
ls
#1734553803
less PVL2_output.out
#1734553858
nano job.script 
#1734553876
qsub job.script
#1734553918
qstat
#1734553968
ls
#1734553974
less PVL2_output.out
#1734553986
nano job.script
#1734554071
less PVL2_output.err
#1734554086
less job.script
#1734554126
qsub job.script
#1734554418
ls
#1734554429
less PVL_output.out
#1734554436
less PVL2_output.out
#1734554456
nano job.script
#1734554495
less job.script
#1734554531
qsub job.script
#1734554656
qstat
#1734554660
ls
#1734554666
less PVL2_output.out
#1734554690
less PVL2_output.err
#1748499562
ls
#1748500174
git init
#1748500188
ls
#1748500196
git status
#1748500205
git add .
#1748500213
git status
#1748500232
git commit -m Â'adding all old files from cluster'
#1748500238
git init
#1748500244
git status
#1748500305
git remote add origin https://github.com/rahuln2025/HPC_course.git
#1748500313
git push -u origin master
#1748500582
git status
ls
pwd
cd HPC_CMS_202425/
ls
pwd
#1749240883
ls
ls
pwd
pwd
ls
cd HPC_CMS
ls
cd ..
pwd
cd HPC_CMS_Home/
ls
pwd
pwd
ls
cd PVL_202425/
ls
cd PVL2
cd PVL2_3
ls -al
less job.script 
cd ..
less .nanorc
ls -al
nano .bashrc
nano
clear
ls /usr/share/nano
less ~/.nanorc
cd ~
ls
cat ~/.nanorc
ls -l
pwd
