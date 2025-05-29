module avail
module load openmpi/gcc
ls
mpicc myprog.C
cd ..
ls
cd rn14pyry
ls
mkdir HPC_CMS
ls
cd HPC_CMS
ls
touch mpprog.C
nano myprog.C
ls
mpicc myprog.C
nano myprog.C 
mpicc myprog.C
ls
mpiexec -n 2 ./a.out
module load python/gcc
ls
rm mpprog.C
ls
nano mpi_first.py
mpiexec -n 2 python3 mpi_first.py
nano mpi_second.py
mpiexec -n 2 python3 mpi_second.py
ls
cd HPC_CMS/
ls
less mpi_first.py 
ls
module list
modules
allmodule
ls
qsub -I -1 select=1:ncpus=8:mpiprocs=8 -q entry_teachingq
qsub -I -l select=1:ncpus=8:mpiprocs=8 -q entry_teachingq
ls
cd HPC_CMS/
ls
cd HPC_CMS
ls
cd ..
mkdir HPC_CMS_Home
ls
cd HPC_CMS_Home
ls
cp ./../HPC_CMS/mpi_first.c ./
cd ../HPC_CMS
ls
cat mpi_second.py 
ls
cat myprog.C 
mv myprog.C mpi_first.C
ls
mv mpi_first.py mpi_second.py ./../HPC_CMS_Home/
ls
cd ..
ls
cd HPC_CMS_Home
ls
module load openmpi/gcc
mpicc mpi_first.py -ompi_mpi_first.py
ls
cp ./../HPC_CMS/mpi_first.C ./
ls
mpicc mpi_first.C -ompi_first.C
mpicc mpi_first.C -o mpi_first.out
ls
nano mpi_hpc23c_3.C
ls
mpicc mpi_hpc23c_3.C -0 mpi_hpc23c_3.out
mpicc mpi_hpc23c_3.C -o mpi_hpc23c_3.out
ls
cat mpi_hpc23c_3.
cat mpi_hpc23c_3.C
cd /home/rn14pyry/pbs.664985.mmaster.x8z
cd ..
ls
cd HPC_CMS_Home/
ls
mpiexec -n 5 ./mpi_hpc23c_6.C
module load openmpi/gcc
mpiexec -n 5 ./mpi_hpc23c_6.C
ls
mpiexec -n 5 ./mpi_hpc23c_6.out
mpiexec -n 32 ./mpi_hpc23c_6.out
exit
ls
cd HPC_CMS_Home/
ls
nano mpi_hpc23c_5.C
mpicc mpi_hpc23c_5.C mpi_hpc23_5.out
module load openmpi/gcc
mpicc mpi_hpc23c_5.C -o mpi_hpc23_5.out
ls
qsub -I -l select=1:ncpus=8:mpiprocs=8 -q entry_teachingq
cd /home/rn14pyry/pbs.664981.mmaster.x8z
ls
cd ..
ls
cd HPC_CMS_Home
ls
module load openmpi/gcc
mpiexec -n 3 ./mpi_first.out
mpiexec -n 3 ./mpi_hpc23c_3.out
mpiexec -n 3 ./mpi_hpc23c_5.out
mpiexec -n 3 ./mpi_hpc23_5.out
ls
nano mpi_hpc23c_5.C
ls
mpiexec -n 3 ./mpi_hpc23c_5.out
echo "Hey I am still there"
echo "Hey"
mpiexec -n 4 ./mpi_hpc23c_6.out 
mpiexec -n 5 ./mpi_hpc23c_6.out 
mpiexec -n 32 ./mpi_hpc23c_6.out 
mpiexec -n 2 ./mpi_hpc23c_6.out 
mpiexec -n 12 ./mpi_hpc23c_6.out 
mpiexec -n 6 ./mpi_hpc23c_6.out 
mpiexec -n 8 ./mpi_hpc23c_6.out 
qsub -I -l select=1:ncpus=40:mpiprocs=40 -q entry_teachingq
ls
cd HPC_CMS_Home/
ls
nano mpi_hpc23_5.C
ls
nano mpi_hpc23c_5.C 
mpicc mpi_hpc23c_5.C -o mpi_hpc23c_5.out
module load openmpi/gcc
mpicc mpi_hpc23c_5.C -o mpi_hpc23c_5.out
ls
rm mpi_hpc23_5.out 
ls
ls -l
echo "Hey I am here man."
cp mpi_hpc23c_5.C mpi_hpc23c_6.C
ls
nano mpi_hpc23c_6.C
ls
cat mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
ls
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
ls
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
ls
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
nano mpi_hpc23c_6.C 
cat mpi_hpc23c_6.C
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
nano mpi_hpc23c_6.C 
mpicc mpi_hpc23c_6.C -o mpi_hpc23c_6.out
exit
ls
cd HPC_CMS_Home
ls
nano mpi_hpc23c_6.C
cat mpi_hpc23c_6.C
cp mpi_hpc23c_6.C mpi_hpc23c_6_1.C
ls
nano mpi_hpc23c_6_1.C 
touch mpi_hpc23c_6.py
nano mpi_hpc23c_6.py
module load python/gcc
exit
cd /home/rn14pyry/pbs.664995.mmaster.x8z
cd ..
ls
cd HPC_CMS_Home
ls
module load openmpi/gcc
mpicc -n 9 mpi_hpc23c_6.out
mpexec -n 9 mpi_hpc23c_6.out
mpiexec -n 9 mpi_hpc23c_6.out
ls
cat mpi_hpc23c_6.C
module load python/gcc
ls
mpiexec -n 2 python3 mpi_hpc23c_6.py
exit
qsub -I -l select=1:ncpus=40:mpiprocs=40 -q entry_teachingq
cd /home/rn14pyry/pbs.666244.mmaster.x8z
cd ..
ls
cd HPC_CMS_Home
ls
module load openmpi/gcc
module load python/gcc
mpiexec -n 2 python3 mpi_hpc23c_6.py
status
job status
jobs
mpiexec -n 2 python3 mpi_hpc23c_6.py
jobs
mpiexec -n 2 python3 mpi_hpc23c_6.py

mpiexec -n 2 python3 mpi_hpc23c_6.py
mpiexec -n 3 python3 mpi_hpc23c_6.py
mpiexec -n 10  python3 mpi_hpc23c_6.py
mpiexec -n 2 python3 mpi_hpc23c_6.py
calculator
mpiexec -n 2 python3 mpi_hpc23c_6.py
mpiexec -n 1 python3 mpi_hpc23c_6.py
mpiexec -n 2 python3 mpi_hpc23c_6.py
mpiexec -n 1 python3 mpi_hpc23c_6.py
mpiexec -n 2 python3 mpi_hpc23c_6.py
mpiexec -n 1 python3 mpi_hpc23c_6.py
mpiexec -n 16  python3 mpi_hpc23c_6.py
mpiexec -n 40 python3 mpi_hpc23c_6.py
mpiexec -n 1 python3 mpi_hpc23c_6.py
mpiexec -n 40 python3 mpi_hpc23c_6.py
mpiexec -n 1 python3 mpi_hpc23c_6.py
exit
cd ..
ls
cd rn14pyry
ls
cd HPC_CMS_Home

less mpi_hpc23c_6.py
nano mpi_hpc23c_6.py
less mpi_hpc23c_6.py 
nano mpi_hpc23c_6.py
ls
exit
exit
#1733089048
ls -l
#1733089156
ls -l HPC_CMS
#1733089189
nano mpi_hpc23c_6.C
#1733089212
nano mpi_hpc23c_6.py
#1733089242
cd HPC_CMS_Home
#1733089246
ls -l
#1733089287
less mpi_hpc23c_6.py
#1734379589
cd /home/rn14pyry/pbs.846263.mmaster02.x8z
#1734380409
exit
#1734388362
cd /home/rn14pyry/pbs.846287.mmaster02.x8z
#1734388403
exit
#1734388465
cd /home/rn14pyry/pbs.846288.mmaster02.x8z
#1734388469
ls
#1734388471
cd ..
#1734388473
ls
#1734388484
cd HPC_CMS_202425/
#1734388485
ls
#1734388543
time ./hello-openmp 
#1734388561
export OMP_NUM_THREADS=4
#1734388565
time ./hello-openmp 
#1734388604
clear
#1734388607
exit
#1734378398
modul avail
#1734378420
module load openmpi/gcc
#1734378464
module load openmpi
#1734378478
ls
#1734378524
module avail
#1734378687
module load openmpi/gcc/11.4/0
#1734378699
module load openmpi/gcc/11.4.0
#1734378774
ls
#1734378782
ls HPC_CMS
#1734378788
ls HPC_CMS_
#1734378791
ls HPC_CMS_Home/
#1734378809
less mpi_first.C
#1734378831
cd HPC_CMS_Home/
#1734378838
less mpi_first.C
#1734378856
nano mpi_first.
#1734378864
ls
#1734378871
rm mpi_first.
#1734378890
nano mpi_first.C
#1734378955
mpicc mpi_first.C
#1734378967
ls
#1734379057
mpiexec -n 2 ./a.out
#1734379507
qstat -Q
#1734379546
qsub -I -q entry_teachingq
#1734380422
ls
#1734380753
nano mpi_hpc24a_2.C
#1734382406
g++ -o hello-openmp main.cpp -00 -fopenmp 
#1734382453
help(g++)
#1734382463
g++ -help
#1734382469
g++ -h
#1734382675
g++ -o hello-openmp  -fopenmp 
#1734382762
g++ -o hello-openmp main.cpp -o0 -fopenmp 
#1734382794
g++ -o hello-openmp main.cpp -O0 -fopenmp 
#1734382809
g++ -o hello-openmp mpi_hpc24a_2.C -O0 -fopenmp 
#1734382965
nano mpi_hpc24a_2.C 
#1734383052
g++ -o hello-openmp mpi_hpc24a_2.C -O0 -fopenmp 
#1734383054
ls
#1734383090
qsub hello-openmp 
#1734383107
ls
#1734383269
cd ..
#1734383281
mkdir HPC_CMS_202425
#1734383288
ls
#1734383336
cp HPC_CMS_Home/mpi_hpc24a_2.C HPC_CMS_202425/
#1734383342
cd HPC_CMS_202425/
#1734383343
ls
#1734383352
g++ -o hello-openmp mpi_hpc24a_2.C -O0 -fopenmp 
#1734383358
qsub hello-openmp 
#1734383360
ls
#1734383388
qstat
#1734383437
ls
#1734383458
less hello-openmp.o846265 
#1734383466
less hello-openmp.e846265 
#1734383728
ls
#1734383752
qstat
#1734383914
nano job.script
#1734383994
cd ~
#1734383995
ls
#1734384005
cd HPC_CMS_202425/
#1734384015
nano job.script 
#1734384084
ls
#1734384099
qsub job.script 
#1734384103
qstat
#1734384108
ls
#1734384125
qstat
#1734384224
ls
#1734384228
less log.out
#1734384293
cat my_file
#1734384301
nano my_file
#1734384318
cat my_file
#1734384324
qsub job.script 
#1734384328
ls
#1734384333
less log.err
#1734384342
qstat
#1734386818
ls
#1734386823
qstat
#1734386827
less log.err
#1734386834
less log.out
#1734386896
less my_file 
#1734386992
less log.out
#1734387116
nano job.script 
#1734387164
qsub job.script 
#1734387170
qstat
#1734387180
ls
#1734387186
less log.out
#1734387203
less log.err
#1734387208
rm log.err
#1734387209
ls
#1734387213
qstat
#1734387222
ls
#1734387231
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
